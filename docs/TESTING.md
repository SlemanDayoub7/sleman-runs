# Testing strategy

The goal is not a coverage number. It is **confidence in the parts that are hard to check by hand**: GPS math, session state transitions, and persistence durability. A GPS bug that only appears after 4 km on a real device cannot be debugged from a screenshot.

---

## Pyramid

| Layer | What | Tool | Target |
| --- | --- | --- | --- |
| Unit — domain | Filtering, distance, splits, pace, streaks, plan generation | `test`, `mocktail` | 90% |
| Unit — cubit | State sequences for every transition | `bloc_test` | 85% |
| Data | Repositories and DAOs against a real in-memory Drift DB | `drift/native.dart` | 80% |
| Widget | Key screens render in 4 modes (en/ar × light/dark) | `flutter_test`, goldens | smoke + goldens |
| Integration | Start → run → finish → history, with fake GPS | `integration_test` | happy path + recovery |

CI runs everything except device integration tests; those run locally before each milestone tag.

---

## 1. Unit tests that earn their keep

### `GpsFilter`

Given a stream of `GpsFix`, assert which fixes are accepted.

| Case | Input | Expected |
| --- | --- | --- |
| Poor accuracy | accuracy 60 m | rejected, `RejectReason.accuracy` |
| Teleport | 400 m in 3 s | rejected, `RejectReason.speed` |
| Duplicate | same coords, 400 ms later | rejected, `RejectReason.duplicate` |
| Normal walk | 5 m, accuracy 6, 3 s | accepted |
| Tunnel gap | 90 s gap, 300 m away | accepted, flagged `hasGap` |

### `DistanceCalculator`

- Haversine against known city pairs (assert within 1 m).
- Elevation gain ignores noise below 0.5 m and does not double-count descents.
- Splits: a 10.4 km track produces 10 full splits + a 0.4 km partial, summing back to total distance (property test).

### Fixtures

Recorded tracks in `test/fixtures/gpx/`:

- `easy_5k_clean.gpx` — open road, good signal
- `city_10k_canopy.gpx` — buildings, reflections, drift
- `trail_half_gap.gpx` — long signal loss
- `walk_intervals.gpx` — stop/start for auto-pause

A small GPX parser in `test/support/` turns them into `GpsFix` lists, so the same data drives filter, distance and auto-pause tests. This is the single most valuable test asset in the repo — and a good post.

### Determinism

No `DateTime.now()` in domain code. Everything takes a `Clock` (injected). Tests advance a `FakeClock` — no `sleep`, no flakiness.

---

## 2. Cubit tests

```dart
blocTest<TrackingCubit, TrackingState>(
  'emits acquiring then active when start succeeds',
  build: () => cubit,
  act: (c) => c.start(),
  expect: () => [isA<TrackingAcquiring>(), isA<TrackingActive>()],
);
```

Required cases: start with permission denied, start with GPS disabled, pause/resume, auto-pause trigger, finish with zero distance (must not save), finish during signal loss, recover unfinished session, failure during persist (state keeps last good metrics).

---

## 3. Data tests

- Real Drift database on a temp file via `NativeDatabase.memory()`, not mocks — SQL bugs hide behind mocks.
- Migration test: create a v1 database with fixture rows, run `onUpgrade`, assert data survives and columns default correctly.
- Batch write test: 10 000 track points insert under 1 s; query a session's points in order.
- Soft delete: deleted runs disappear from `watchRuns` but remain for sync.

---

## 4. Widget, layout and golden tests

Widget tests cover the design system contract, not just "does it render":

| Suite | What it proves |
| --- | --- |
| `test/shared/widgets/app_text_test.dart` | Roles map to the type scale; tones resolve per theme; metrics stay LTR in Arabic; semantics/maxLines forward |
| `test/shared/widgets/app_button_test.dart` | Tap, disabled, loading spinner blocks taps, full-width mode, icon + label |
| `test/shared/widgets/app_scaffold_test.dart` | 20/24 dp gutters, 600 dp content cap, full-bleed escape hatch |
| `test/shared/widgets/app_feedback_test.dart` | Badge, skeleton, metric semantics, section header, empty state at 320 dp / 200% |
| `test/shared/widgets/app_error_view_test.dart` | Every `FailureCode` maps to exactly one localised sentence (EN + AR) and retry fires |
| `test/app/theme/design_theme_test.dart` | Four cached variants, type scale, variable-font weights, Arabic +10% line height, component tokens |

### Responsive matrix

`test/app/responsive/layout_matrix_test.dart` renders all four screens at:

- widths `320`, `412`, `840` dp;
- text scale `1.0` and `2.0`;
- all four variants (`en`/`ar` × light/dark).

That is 96 combinations. Each one fails on an overflow exception, a wrong `Directionality` or a wrong brightness. This is the test that makes "portrait on phones, responsive everywhere" real rather than aspirational — Android 16 ignores orientation locks on large displays ([ADR-0014](adr/0014-portrait-phones-responsive-layout.md)).

### Pixel goldens

Sixteen baselines: four screens (tracking, history, plan, settings) × four theme variants, at the 412 × 915 design surface.

- Fonts are loaded from `assets/fonts/` through `FontLoader` in `test/support/load_fonts.dart`. Widget tests otherwise use Ahem, which would make every baseline meaningless.
- Goldens are **opt-in locally** so a normal `flutter test` is fast and does not fail on OS font rasterisation:

```bash
RUN_GOLDENS=1 flutter test --update-goldens test/goldens   # accept a change
RUN_GOLDENS=1 flutter test test/goldens                    # compare
```

- CI runs the comparison on **`windows-latest`**, the platform the baselines were generated on. A Linux runner would report diffs for identical UI.
- Reviewing a golden diff is how RTL overflow and a stray colour get caught in seconds instead of at launch.

### What is not painted

The map is excluded from pixel goldens: tile rendering is non-deterministic. Assert the polyline, marker and attribution widgets exist instead (Week 5).

---

## 5. Manual device checklist (before each tag)

- [ ] 5 km outdoor run, screen off, notification updates
- [ ] Kill app mid-run → reopen → recovery prompt restores the session
- [ ] Airplane mode mid-run → no crash, points buffered
- [ ] Deny permission → settings deep link works
- [ ] Arabic + dark mode: no clipped text on tracking, history, plan
- [ ] 200% text scale on tracking screen
- [ ] Battery: < 8% per hour of tracking on the test device
- [ ] Low-end Android: no dropped frames on the live screen (DevTools timeline)

Results go in `docs/perf/device-matrix.md` with device, OS and build hash. Numbers, not vibes.

---

## 6. CI gates

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos
dart run dependency_validator
flutter test --coverage
flutter build apk --debug
```

Plus, on a Windows runner:

```bash
RUN_GOLDENS=1 flutter test test/goldens
```

PRs cannot merge with a red check. Coverage is reported, not gated at a fixed number — a gate on a percentage rewards testing getters. The golden job is required even though it is slower: a design system that is not pixel-verified is a design suggestion.

---

## 7. What we deliberately do not test

- Generated code (`*.freezed.dart`, `*.g.dart`, l10n).
- Third-party plugin internals; we test our wrapper's contract instead.
- Pixel-perfect goldens for the map (tile rendering is non-deterministic) — assert the polyline and markers exist instead.
- Pixel goldens on every CI operating system. Baselines are Windows-only by design; the layout matrix is the cross-platform guard.
