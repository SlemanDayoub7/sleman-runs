# ADR-0011 — No web target

- **Status:** Accepted
- **Date:** 2026-11-03
- **Supersedes:** [ADR-0010](0010-web-demo-scope.md)

## Context

ADR-0010 proposed a web showcase to give recruiters a clickable link. On review, the cost/benefit does not hold for this project:

1. **The core feature cannot work there.** A browser tab cannot record a run with the screen off. Any web build is a tour of a product it cannot be, which invites the wrong conclusion.
2. **It is a second surface, not a page.** Responsive layout, wasm-backed persistence, a separate CI target, tile policy, release cadence, and web-only bugs — days of work that improve neither the mobile app nor the hiring signal.
3. **The link problem has a cheaper solution.** A 60-second video, a README GIF, an APK on GitHub Releases, and a QR code get a reviewer to "I get it" faster than a browser tab.

The project is time-boxed to eight weeks and GPS is in scope. The web build competes directly with the feature that makes the project interesting.

## Decision

**No web target. Ever, for this project.**

- `flutter create --platforms android` — no `web/` directory, and no iOS target for v1 ([ADR-0012](0012-android-only-v1.md)).
- No GitHub Pages, no showcase build, no wasm persistence, no responsive web layout.
- ADR-0010 is superseded and retained only as history.
- Nothing in the codebase may depend on web: no `kIsWeb` branches, no web-only packages.

Proof strategy instead:

| Artifact | Purpose |
| --- | --- |
| 60-second demo video (captions, sound off) | The pitch, works in every feed |
| Animated GIF in the README | The 5-second impression |
| APK on GitHub Releases | Real GPS, real device |
| QR code in the launch post | Removes the "type a URL" step |
| Case study PDF | The depth, for interviews |

## Alternatives considered

- **Web showcase with seeded data (ADR-0010):** honest and clickable, but a day lost plus ongoing maintenance for a surface that cannot demonstrate the product's reason to exist. Rejected on cost.
- **Live browser GPS:** works for a 5-minute walk with the tab focused, fails the actual use case, misrepresents the app. Rejected.
- **Video only:** in fact this is what ships — but paired with the APK and the repo, not as a substitute for them.

## Consequences

- Saves roughly two days across the eight weeks; they go to GPS reliability and tests.
- The demo depends on video quality, not just app quality. Budget real time for recording and captions.
- Recruiters who will not install anything are reached by the video and the README, not by a broken "Start run" button.
- `LocationDataSource` stays abstract — for tests and for a future platform, not for a browser.
