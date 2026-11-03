# ADR-0010 — Web is a showcase, not a platform

- **Status:** Accepted
- **Date:** 2026-11-03
- **Related:** [ADR-0004](0004-offline-first-with-drift.md), [ADR-0006](0006-live-gps-tracking-stack.md), [ADR-0007](0007-flutter-map-over-google-maps.md)

## Context

The repo needs a link a recruiter can click from a laptop. A Flutter web build is the obvious answer, but the core feature — recording a run with the screen off — physically cannot work in a browser: there is no foreground service, no background execution, and mobile browsers throttle or suspend a backgrounded tab.

Shipping a web build that silently cannot track a run would be worse than shipping none: a reviewer would click "Start run", see nothing, and conclude the app is broken.

## Decision

Ship a **web showcase**, clearly labelled as such, with a hard one-day timebox.

What the showcase contains:

- Seeded data: 20 runs across 12 weeks, so history, stats and charts are populated on first load.
- **Replay mode** for the tracking screen: a recorded GPX track is fed through `LocationDataSource`, the same port used by the real device source. Map, timer, pace and splits animate exactly as in production.
- Full theme switching, English/Arabic + RTL, plans and pace calculator.
- A persistent banner: *"Showcase build — live GPS runs in the mobile app."*

What it does not do:

- No background recording, no foreground notification, no permission flow (the browser handles it).
- No claim of production support for web. Bugs that only affect web are triaged below mobile.

Persistence on web uses Drift's `WasmDatabase` with `sqlite3.wasm` + `drift_worker.js`. If that proves unstable within the timebox, the fallback is a `DemoRunRepository` implementing the same port with an in-memory list — the architecture already allows it, and the swap is confined to one registration line.

**De-risking:** a one-hour spike in Week 1 (build web, wire wasm, deploy to Pages) instead of discovering problems in Week 7.

## Alternatives considered

- **No web build; video + GIF + APK only.** Zero risk, but recruiters on desktop convert far worse and the repo loses its most clickable artifact.
- **Full web product with live browser GPS.** Works for a 5-minute walk with the tab open on HTTPS, fails for the actual use case, and would misrepresent the app. Rejected.
- **Separate "product tour" app.** Duplicates UI and drifts out of sync. The replay-mode approach shares 100% of the presentation layer.
- **Embedded YouTube demo instead of a web build.** Good complement, not a replacement — a video cannot be clicked around.

## Consequences

- The demo is honest, and the limitation becomes a documented engineering decision rather than an apology.
- `LocationDataSource` gains a third implementation (device, fake, replay), which strengthens the case for the abstraction and is directly reusable in tests.
- One extra day in Week 7, one hour in Week 1.
- Web-only defects are explicitly out of the release bar.
