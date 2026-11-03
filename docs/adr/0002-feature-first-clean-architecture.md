# ADR-0002 — Feature-first clean architecture

- **Status:** Accepted
- **Date:** 2026-11-03
- **Related:** [ADR-0003](0003-bloc-for-state-management.md)

## Context

Two common layouts: layer-first (`lib/models`, `lib/services`, `lib/screens`) and feature-first (`lib/features/tracking/{domain,data,presentation}`). This app has five distinct features that will grow unevenly, and the GPS feature will be far more complex than settings.

## Decision

Feature-first, with three layers inside each feature. Dependencies point inward only: `presentation → domain ← data`. Domain is pure Dart and imports no Flutter or plugin code.

Rules:

- A feature never imports another feature's `data` or `presentation`.
- Cross-feature reuse lives in `shared/` or behind a domain port.
- `core/` holds infrastructure and imports no feature.
- Layering is verified in CI with `dependency_validator`.

## Alternatives considered

- **Layer-first:** simpler for five files, becomes a hunt for related code at ~150 files. Rejected.
- **Package-per-feature (melos monorepo):** real boundaries and faster incremental builds, but overkill and extra ceremony for a solo 8-week build. Revisit if a backend and a second app appear.
- **Single `lib/` with no layers:** fastest to start, impossible to test domain logic in isolation, and it demonstrates nothing. Rejected.

## Consequences

- New features are additive: one folder, three subfolders.
- Some duplication between features is accepted as the cost of isolation.
- Boundaries require discipline; the CI check and PR template enforce them.
