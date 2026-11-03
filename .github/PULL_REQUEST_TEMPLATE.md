## What

<!-- One or two sentences. What changes for the user or the codebase? -->

## Why

<!-- The problem, the constraint, or the decision behind it. Link the issue. -->

Closes #

## How

<!-- Approach, and any trade-off a reviewer should push back on. -->

## Type

- [ ] `feat` — new capability
- [ ] `fix` — defect
- [ ] `refactor` — no behavior change
- [ ] `perf` — performance
- [ ] `test` — tests only
- [ ] `docs` — documentation / ADR
- [ ] `ci` / `chore` — tooling

## Screenshots

<!-- Required for UI changes. Light + dark. English + Arabic. GIF for flows. -->

| Light | Dark |
| --- | --- |
|  |  |

## Checklist

- [ ] Title follows the commit convention (`type(scope): summary`)
- [ ] One concern only; no unrelated changes
- [ ] `dart format .`, `flutter analyze`, `flutter test` pass locally
- [ ] Tests added/updated for domain logic
- [ ] No hardcoded strings, colors, radii or durations
- [ ] Docs or ADR updated if a decision or behavior changed
- [ ] Verified in both themes and both locales where relevant
- [ ] No secrets, no commented-out code, no untracked TODOs

## Notes for the reviewer

<!-- Anything you are unsure about. Pointing at your own weak spots gets better reviews. -->
