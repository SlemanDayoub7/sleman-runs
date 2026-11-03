# ADR-0005 — go_router for navigation

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

Navigation needs: a bottom-nav shell that preserves per-tab state, a deep link into a finished run (`/runs/:id`) from a notification, an onboarding redirect when no goal exists, and guards that never leave the user on a dead screen.

## Decision

`go_router` with typed path constants, a `StatefulShellRoute.indexedStack` for the tab shell, and redirect-based guards.

- Routes are declared in one file; no string paths in widgets — use `const Routes.runDetail(id)` helpers.
- Guards live in `redirect` and read a small `SessionGate` (onboarding complete? units chosen?) — no navigation logic in Cubits.
- Deep links: `/runs/:id`, `/track`, `/plan/:id`.
- Errors render a real 404 page, not a blank screen.

## Alternatives considered

- **Navigator 1.0:** no URL support, painful nested shells, worse deep-link story.
- **`auto_route`:** typed and powerful, adds codegen and a large surface for a small app. Its generated files dominate the diff.
- **`beamer`:** interesting for nested navigation, smaller community and fewer examples for the shell pattern.

## Consequences

- Deep links make notification taps and "resume run" reliable, which matters more than the extra dependency.
- Guards centralize "where can the user be" logic.
- Slight learning curve for `StatefulShellRoute`, documented in the router file.
