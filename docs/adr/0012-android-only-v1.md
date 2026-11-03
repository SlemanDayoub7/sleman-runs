# ADR-0012 — Android-only for v1

- **Status:** Accepted
- **Date:** 2026-11-03
- **Related:** [ADR-0006](0006-live-gps-tracking-stack.md), [ADR-0011](0011-no-web-target.md)

## Context

Flutter makes cross-platform cheap for UI, but not for a background location app. iOS adds a Mac, Xcode, provisioning profiles, App Store review (including background-location justification), and device testing on hardware I do not have. The project budget is eight weeks and the hard part is the GPS pipeline, not a second build target.

There is also a quality argument: Android is where background location is hardest — aggressive OEM task killers, Android 14 foreground-service types, Doze, battery-optimisation exemptions. Shipping that well is a stronger signal than shipping two mediocre builds.

## Decision

**v1 targets Android only.**

- `flutter create --org com.sleman --platforms=android .` — no `ios/` directory, no Xcode project, no Podfile.
- Version floor: Android 8.0 (API 26); target the latest stable SDK required by Play.
- CI builds `app-release.apk` and `appbundle`; distribution starts as a GitHub Release APK, with Play Console as an optional extra ($25 one-time, no subscription).
- **Deferred, not forbidden:** iOS can be added later with `flutter create --platforms=ios .` plus platform config. Nothing in the architecture blocks it.
- Platform-agnostic code is still a rule: no `android.*` imports above `data`, no Android-only types in domain, no UI that assumes hardware buttons. `geo`, `permissions` and `foreground task` remain behind `LocationDataSource`.

## Alternatives considered

- **Android + iOS:** better reach and a nicer story for "cross-platform developer". Rejected for v1 on hardware access, Mac availability, and review time — each costs days that the GPS pipeline needs.
- **Android + web:** already rejected in [ADR-0011](0011-no-web-target.md).
- **Android + iOS + web:** three surfaces, one developer, eight weeks. Not serious.

## Consequences

- Every remaining day goes into tracking reliability, tests and polish — the parts a reviewer can actually evaluate.
- Store screenshots and assets are produced once, for Play (phone + 7" tablet if easy).
- Job applications say "Flutter, Android-first" rather than "cross-platform" — narrower but truthful, and the repo carries the depth.
- Answering "why no iOS?" becomes a deliberate talking point, not a gap: *one platform done properly beats three done halfway*.
- If a role requires iOS, the port is a command plus platform config, not a rewrite — worth saying out loud in interviews.
