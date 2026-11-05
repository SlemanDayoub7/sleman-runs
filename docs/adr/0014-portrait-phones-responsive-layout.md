# ADR-0014 — Portrait on phones, responsive everywhere

- **Status:** Accepted
- **Date:** 2026-11-05
- **Related:** [ADR-0012](0012-android-only-v1.md), [DESIGN.md](../DESIGN.md)

## Context

Sleman Runs is used one-handed while moving. The tracking screen is a single-column stack of large metrics and one primary action, and that layout is better in portrait: the thumb reaches the start button, the map keeps a usable aspect ratio, and the phone does not rotate every time a runner glances at it.

Android has always allowed an app to request a fixed orientation, so the obvious implementation is `android:screenOrientation="portrait"` plus `SystemChrome.setPreferredOrientations`. That is no longer sufficient.

**Android 16 ignores orientation locks on displays whose smallest width is at least 600 dp.** Tablets, unfolded foldables and desktop-window mode are therefore reachable whether the app asks for portrait or not. A layout that only works at 360–430 dp would letterbox, clip or crash on those devices, and the Play listing targets Android 8+ with a current target SDK.

There is also an accessibility constraint independent of Android version: at 200% text scaling, a single screen can need far more vertical space than the viewport. Locking orientation must never mean locking content out.

## Decision

**Phones stay portrait. The UI is width-responsive, not orientation-dependent.**

1. **Request portrait on phones.** `bootstrap()` calls
   `SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])`, and the manifest declares `android:screenOrientation="portrait"`. This covers phones on Android 15 and below and keeps the intended one-handed experience.

2. **Never assume the request succeeded.** Every layout decision reads width through `context.window`, which maps to Material 3 window classes:

   | Class | Width | Typical device |
   | --- | --- | --- |
   | `compact` | `< 600` | phone portrait |
   | `medium` | `600–839` | small tablet, unfolded foldable |
   | `expanded` | `>= 840` | tablet, desktop window |

3. **One page shell owns the responsive rules.** `AppScaffold` applies a `20 dp` gutter on compact widths and `24 dp` on wider ones, caps content at `600 dp`, and centres it. Full-bleed screens (the map) opt out of the cap but still respect safe areas.

4. **Content scrolls before it clips.** Empty states, error views and settings are scrollable and height-aware; buttons and chips wrap instead of shrinking. The type scale uses logical, scalable text and no fixed-height text boxes.

5. **The matrix is tested.** `test/app/responsive/layout_matrix_test.dart` renders all four screens at `320`, `412` and `840 dp`, at `1.0` and `2.0` text scale, in all four theme variants — 96 combinations — and fails on any overflow exception or wrong direction/brightness.

6. **Orientation is not a state input.** No widget branches on `MediaQuery.orientation`; width is the only layout signal. That keeps phones, tablets and split-screen windows on the same code path.

## Alternatives considered

- **Landscape support on phones.** Rejected for v1: it doubles the layout surface of the live-run screen for a use case (watching a phone rotate mid-run) that hurts more than it helps. The responsive rules mean adding it later is a manifest change plus layout review, not a rewrite.
- **Portrait lock only, no responsive fallback.** Rejected because Android 16 makes it unenforceable on large displays. It would ship a broken tablet experience by design.
- **`flutter_screenutil`-style scaling from a design mock.** Rejected: proportional scaling makes text smaller on small phones and larger on tablets, breaks accessibility scaling, and adds a dependency for arithmetic that `LayoutBuilder` and window classes already solve.
- **A separate tablet UI with a navigation rail and master-detail panes.** Premature. The product has one list and one live screen; a capped, centred column is the honest v1. A rail can be added when History actually has a detail pane.
- **Landscape-only on tablets.** Rejected: foldables change posture while in use, and locking the app to an orientation we cannot enforce is the same mistake in reverse.

## Consequences

- The phone experience stays focused; tablets get a readable, centred column instead of a stretched phone.
- Every new screen inherits the gutters, content cap and scroll behaviour from `AppScaffold`. A screen that bypasses it is a code-review smell.
- The 96-combination matrix is slower than a smoke test but catches the failures that matter: overflow at 320 dp / 200%, and RTL at tablet width.
- Golden baselines cover the four theme variants at the design width (412 dp). The matrix covers the widths goldens do not.
- Android 16 large-screen behaviour is handled by layout, not by fighting the OS. If a future release wants landscape on tablets, only the manifest and copy need revisiting.
