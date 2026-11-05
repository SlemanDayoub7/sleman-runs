# ADR-0015 — Bundled fonts, one family per script

- **Status:** Accepted
- **Date:** 2026-11-05
- **Related:** [DESIGN.md](../DESIGN.md), [THIRD_PARTY_NOTICES.md](../../THIRD_PARTY_NOTICES.md)

## Context

The app has to look the same on the first launch, in airplane mode, on a device with no Google Play Services. That rules out downloading a font at runtime. It also has to render two writing systems well: Latin UI plus a large mono/tabular role for timers and pace, and Arabic UI with taller ascenders and different metrics.

The default platform font would make the product look different on every OEM skin and would give no tabular figures on Android's default sans. Timers would visibly jitter as digits change width, which is exactly the kind of defect a running app cannot ship.

Three candidate approaches existed:

1. Use the platform font and accept the inconsistency.
2. Add `google_fonts` and fetch families on first use.
3. Bundle the font files and load them through `pubspec.yaml`.

## Decision

**Bundle three OFL families in the APK and select them per locale.**

| Family | Files | Role | Why |
| --- | --- | --- | --- |
| **Manrope** | `Manrope[wght].ttf` (variable) | Latin UI, headings, body | Geometric, open apertures, legible at 12–16 sp; variable weight means one file covers 400–700. |
| **JetBrains Mono** | `JetBrainsMono[wght].ttf` (variable) | Timer, distance, pace, splits | Tabular by default, unambiguous `1/l/I` and `0/O`; weights are set through the `wght` axis. |
| **IBM Plex Sans Arabic** | Regular / Medium / SemiBold / Bold | Arabic UI | Designed for Arabic alongside Latin, correct shaping and diacritics; ships as static faces, so weight uses `fontWeight`. |

Rules that follow from the choice:

- **No `google_fonts`, no runtime fetch, no fallback flash.** Fonts are declared in `pubspec.yaml`, so they are in the asset bundle before the first frame.
- **Weight is explicit.** Variable families set `fontVariations: [FontVariation('wght', n)]`; the static Arabic family sets `TextStyle.fontWeight`. Mixing the two mechanisms would silently render a synthetic weight.
- **Arabic gets 10% more line height**, applied in `buildTextTheme`, because its ascenders and descenders are taller than Manrope's at the same size. The mono metric is exempt: timers keep the same height in both locales.
- **The mono role is always LTR and tabular**, even inside an RTL layout. `AppText.metric` and `AppMetric` force `TextDirection.ltr`; the number is data, not prose.
- **Licences ship with the app.** The three `OFL.txt` files live next to the fonts, are declared as bundled assets, and are listed in [THIRD_PARTY_NOTICES.md](../../THIRD_PARTY_NOTICES.md). OFL permits bundling in a commercial app; it requires the licence text and forbids selling the fonts alone.

## Alternatives considered

- **`google_fonts` runtime download.** Rejected: first-run network dependency, a visible font swap on slow connections, and a product that looks broken in airplane mode — the exact mode the offline-first pitch is built on. Its caching also adds files and failure paths for no benefit over a 600 KB asset.
- **Platform font (`Roboto` / OEM skin).** Rejected: no tabular figures, different letterforms on every device, and Arabic falls back to a system face whose line height we cannot control. Cheap in APK size, expensive in product consistency.
- **A single family for Latin and Arabic.** Rejected: very few families do both scripts at production quality, and a mismatched Arabic fallback is immediately visible to the audience the app is partly built for.
- **Subsetting or converting to WOFF2.** Deferred. TTF variable fonts keep the build simple and the toolchain standard. If APK size becomes a problem, subsetting is a build-step change with no UI impact.
- **Static Manrope weights only.** Rejected: four to six files instead of one, and the variable file is already smaller than two static weights.

## Consequences

- APK grows by roughly 1.5 MB (fonts plus licences). For an offline GPS app that is a fair trade; the full size is tracked in [PERFORMANCE.md](../PERFORMANCE.md).
- Goldens are deterministic: the same bytes are loaded through `FontLoader` in `test/support/load_fonts.dart` on every machine.
- The type scale is defined once in `lib/app/theme/app_typography.dart`; a font change is a pubspec + one-file change, not a screen-by-screen audit.
- Arabic line height is a deliberate +10%, not an accident of the fallback font. It is asserted in `test/app/theme/design_theme_test.dart`.
- Adding a new script later means adding a family and a locale branch, not replacing the system.
- OFL obligations are visible in the repo and in the release notes; the fonts are never sold or relicensed as the product's own.
