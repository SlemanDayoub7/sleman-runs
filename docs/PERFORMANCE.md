# Performance

Performance is a feature of a running app: a dropped frame while the map moves, or a battery drain on a 10K, is a product defect. This file holds the budgets, the measured baseline and the protocol for keeping both honest.

Numbers are measured on the development machine (Windows, Flutter 3.41.2, Dart 3.11) and a physical Android device once one is available. Every row names the command that produced it so a future change can be compared like for like.

---

## 1. Budgets

| Metric | Budget | Status |
| --- | --- | --- |
| Cold start, release, mid-range phone | < 2.0 s | pending device |
| Warm start | < 800 ms | pending device |
| First usable frame | < 500 ms | pending device |
| UI frame (build + raster, p95) | < 16 ms | pending GPS/map |
| Janky frames during scroll | < 1% | pending lists |
| Universal release APK | < 60 MB | measured below |
| Per-device download (AAB) | < 20 MB | not built yet |
| Idle memory | < 120 MB | pending device |
| Memory while tracking | < 200 MB | pending Week 5 |
| Battery, screen on, GPS recording | < 8% / hour | pending Week 5 |
| Golden baselines in the repo | < 500 KB | measured below |

Budgets are deliberately loose enough to be achievable on a 2020 mid-range phone and tight enough to catch a regression. A number that is only met on a flagship is not a budget.

---

## 2. Week 2 baseline

Week 2 has no database, GPS or map yet. These are the costs the design system adds on its own.

### Build artifacts

| Artifact | Size | Notes |
| --- | --- | --- |
| `app-release.apk` (universal, unsigned) | 46.5 MiB (48,767,585 B) | The shipping artifact until Week 8 signing. |
| Per-ABI release APK (estimated) | 13–17 MiB | ~45 MiB of the universal APK is three copies of the Flutter engine and AOT snapshot. `--split-per-abi` or an AAB ships one. |
| `app-debug.apk` (universal) | 142.4 MiB (149,352,233 B) | Includes all ABIs, debug symbols and the JIT snapshot. Never a shipping metric. |

The universal APK is dominated by native code, not by the design system:

| Content | Size |
| --- | --- |
| `lib/*/libflutter.so` (x86_64, arm64-v8a, armeabi-v7a) | 30.7 MiB |
| `lib/*/libapp.so` (AOT snapshot, three ABIs) | 14.3 MiB |
| Fonts and licence texts | 1.27 MiB |
| `classes.dex` | 0.97 MiB |
| Everything else (resources, manifest, notices) | < 0.5 MiB |

A per-device install therefore pays for one engine and one snapshot, roughly 15 MiB, which is why the per-device budget is 20 MB rather than the universal budget.

### Bundled assets

| Asset | Size |
| --- | --- |
| Manrope variable | 164,700 B |
| JetBrains Mono variable | 187,208 B |
| IBM Plex Sans Arabic, four static weights | 969,632 B |
| Three OFL licence texts | 13,242 B |
| **Fonts + licences** | **1,334,782 B (1.27 MiB)** |

The fonts are the largest deliberate addition in Week 2. They are bundled rather than downloaded so the first frame is correct in airplane mode — see [ADR-0015](adr/0015-bundled-fonts.md). Subsetting is the escape hatch if size becomes a problem.

### Test suite

| Check | Result |
| --- | --- |
| `flutter analyze --fatal-infos` | No issues, ~8 s warm / ~110 s cold after `pub get` |
| `flutter test` | 79 passed, 16 goldens skipped; 32 s running, 56 s including compilation |
| `RUN_GOLDENS=1 flutter test test/goldens` | 16 passed; 6 s running, 20 s including compilation |
| Golden baselines on disk | 16 PNGs, 198,948 B (194 KiB) at 412 × 915 |

The 96-combination layout matrix is the slowest widget suite. It is worth its runtime because overflow at 320 dp / 200% text is a real device failure, not a hypothetical.

### Not yet measured

Cold start, warm start, frame timing, memory and battery need a physical Android device. There is no emulator or phone connected to the development machine in Week 2, and an Edge web tab is not a valid Android target. These rows move from *pending* to measured in Week 5, when the app actually does background GPS work and the numbers start to matter.

---

## 3. How to measure

Run these from the repository root. The first two produce an interactive size breakdown in the terminal and a JSON report under `build/`.

```bash
# APK and AAB size, with per-package attribution
flutter build apk --release --analyze-size
flutter build appbundle --release --analyze-size

# One APK per ABI, which is what a GitHub Release should attach
flutter build apk --release --split-per-abi

# Startup trace (device required)
flutter run --profile --trace-startup

# Frame timings, memory and CPU (device required)
flutter run --profile
# then open DevTools > Performance / Memory
```

On PowerShell, wrap the commands in `Measure-Command { ... }` for wall-clock numbers, and use `(Get-Item <artifact>).Length` for exact bytes.

When reading startup numbers, take the median of five cold starts after a reboot or a force-stop, not the first launch after an install. The first launch includes ahead-of-time compilation and asset extraction and will always look worse.

---

## 4. What is already optimised

These choices exist to protect the budgets above, not for style:

- **Four cached `ThemeData` objects.** Switching theme is a map lookup; the app never rebuilds a theme per frame or per route.
- **Static tokens.** Spacing, size, radius and motion are compile-time constants, so Flutter does not interpolate `ThemeExtension`s during every theme transition.
- **`RepaintBoundary` around live metrics.** A ticking timer repaints its own layer, not the screen (see `AppMetric`).
- **Flat, bordered surfaces.** No shadows to rasterise on every scroll; depth comes from surface steps and a 1 dp hairline.
- **No decorative animation.** `AppSkeleton` is a static block; there is no shimmer loop spending frames on information the user can already infer.
- **Bundled fonts.** No network fetch, no font swap, no first-run dependency.
- **Const-friendly widgets.** Every shared widget takes `const` where its inputs allow it, and screens build small leaf widgets rather than one large `build`.
- **Tree-shaken icons and Material.** Flutter's default tree shaking removes unused icon glyphs from release builds.

Week 5 adds the costs that will actually dominate: a foreground service, a GPS stream at 1 Hz, SQLite writes and map tiles. Those get their own budget review and, if needed, fixes such as batched inserts, a reduced tile cache and a polyline that updates at a lower cadence than the timer.

---

## 5. Regression protocol

1. **Every PR** runs format, analysis, dependency validation and the full test suite. A red check blocks merge.
2. **Any PR that adds a dependency or an asset** records the release APK delta in the PR description. A jump over 10% needs a reason and, if accepted, a note here.
3. **Every milestone** rebuilds `app-release.apk` and updates the baseline table in this file. The number is committed with the milestone, not remembered in a chat.
4. **Week 5 onward**, profile mode startup, frame timing and memory are measured on a physical device and recorded before the milestone closes.
5. **A performance fix ships with a measurement**, before and after, in the same PR. "Feels faster" is not a result.

The golden job protects pixels, the layout matrix protects reflow, and this file protects the numbers that neither can see.

---

## 6. History

| Date | Milestone | Release APK | Fonts | Notes |
| --- | --- | --- | --- | --- |
| 2026-11-05 | v0.2.0 design system | 46.5 MiB universal | 1.27 MiB | First measured baseline; ~15 MiB per device; no GPS, DB or map yet |
