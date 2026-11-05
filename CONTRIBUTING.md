# Contributing

This is a solo build-in-public project, but it is run like a team repo on purpose. The conventions below are the point, not decoration.

---

## 1. Branching model

Trunk-based development with short-lived branches. `main` is always releasable.

```
main ──●──●──────●──────●──▶   (protected, squash-merged)
        \        /  \    /
         ●──●──●    ●──●        feat/run-log, fix/pace-rounding
```

| Prefix | Use | Example |
| --- | --- | --- |
| `feat/` | New user-visible capability | `feat/live-tracking` |
| `fix/` | Defect fix | `fix/split-rounding` |
| `refactor/` | Behavior-preserving change | `refactor/gps-filter` |
| `test/` | Tests only | `test/gpx-fixtures` |
| `docs/` | Docs, ADRs, README | `docs/adr-0006-gps` |
| `ci/` | Workflows, tooling | `ci/add-coverage` |
| `chore/` | Dependencies, housekeeping | `chore/bump-drift` |
| `perf/` | Performance work | `perf/track-point-batching` |

Rules:

- Branch off `main`, live for ≤ 3 days, one concern per branch.
- `main` is protected: no direct pushes, PR required, CI must be green.
- Squash merge only, so `main` history is one commit per change.
- Delete the branch after merge.
- Rebase on `main` before requesting review; never merge `main` into a feature branch.

## 2. Commit messages

[Conventional Commits](https://www.conventionalcommits.org), enforced in CI.

```
<type>(<scope>): <imperative summary, ≤ 72 chars>

Why this change is needed, what it replaces, and anything
non-obvious about the approach. Wrap at 72.
```

`type` ∈ `feat fix refactor test docs ci chore perf revert`
`scope` ∈ a feature or area: `tracking`, `history`, `stats`, `plans`, `theme`, `l10n`, `db`, `router`, `di`, `repo`

Good:

```
feat(tracking): filter gps fixes by accuracy and implied speed

Raw fixes include reflections that teleport the track by 400 m.
Reject anything above 25 m accuracy or 12 m/s implied speed,
and flag gaps over 60 s so splits can exclude them.
```

Bad: `update code`, `fixes`, `WIP`, `final final`.

Small, working commits beat one large commit. If a commit needs "and" in the message, split it.

## 3. Pull requests

Every PR uses the template. A PR is ready when:

- [ ] Title follows the commit convention
- [ ] The *why* is explained, not just the *what*
- [ ] Screenshots or a short clip for any UI change (light + dark, en + ar)
- [ ] Tests added or updated for domain logic
- [ ] `dart format`, `flutter analyze`, `flutter test` pass locally
- [ ] Docs/ADR updated if a decision or behavior changed
- [ ] No unrelated changes, no commented-out code, no `TODO` without an issue link
- [ ] If it closes an issue: `Closes #12`

Review your own diff in the GitHub UI before merging. It catches more than you expect.

## 4. Code standards

- `very_good_analysis` plus project rules in `analysis_options.yaml`; `--fatal-infos` in CI.
- Domain layer: no Flutter imports, no plugin imports, no `DateTime.now()` (inject `Clock`).
- No user-facing string literals — everything through ARB.
- No raw colors, radii or durations — tokens only.
- Failures over exceptions across boundaries; `Result<T>` from use cases.
- Prefer `const` constructors, `final` fields, immutable state.
- Name by intent: `activeSession`, not `data`; `hasSufficientAccuracy`, not `check`.
- A comment explains *why*. Code explains *what*.

## 5. Local workflow

```bash
git switch main && git pull
git switch -c feat/live-tracking

# edit, then
dart format .
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

git add -p
git commit -m "feat(tracking): ..."
git push -u origin HEAD
gh pr create --fill
```

### Pixel goldens

Pixel comparison is opt-in locally so `flutter test` stays fast and does not fail on OS-specific font rasterisation. Goldens are verified in CI on **Windows**, the platform the baselines were generated on:

PowerShell:

```powershell
$env:RUN_GOLDENS='1'; flutter test test/goldens                    # compare
$env:RUN_GOLDENS='1'; flutter test --update-goldens test/goldens   # accept a change
```

Bash:

```bash
RUN_GOLDENS=1 flutter test test/goldens
RUN_GOLDENS=1 flutter test --update-goldens test/goldens
```

Regenerate a baseline only after reviewing the diff, and commit the PNGs with the code change that caused them. Never regenerate on Linux: the golden job runs on `windows-latest` and a Linux baseline would produce false diffs.

The layout matrix (`flutter test test/app/responsive`) always runs and is the cross-platform guard for overflow, RTL and brightness at 320/412/840 dp.

Hooks via `lefthook` (added in Week 1) run format + analyze on commit and tests on push.

## 6. Issues and labels

- Epics mirror roadmap milestones (`epic`).
- Every issue has: context, acceptance criteria, out of scope, screens.
- Labels: `epic feat fix test docs ci design perf content good first issue blocked`.
- Work is tracked on a GitHub Projects board: `Backlog → This week → In progress → Review → Done`.
- Anything outside the current milestone goes to the v2 backlog. No scope creep mid-week.

## 7. Releases

Semantic versioning, tagged from `main`:

- `v0.x.0` — milestone complete (pre-1.0, breaking changes allowed)
- `v1.0.0` — first public release
- `v1.x.y` — patch, `v1.x.0` — feature

Process:

1. Merge everything intended for the release; CI green.
2. Update `CHANGELOG.md` under a new version heading (Keep a Changelog format).
3. `git tag -a v0.6.0 -m "v0.6.0 — history"` and push the tag.
4. GitHub Release with notes, screenshots and the demo link.
5. Post about it.

`release-please` automates steps 2–4 once the repo is public (Week 3).

## 8. Security and secrets

- No keys, tokens or `.env` files in the repo. `--dart-define` for build-time config, GitHub Secrets in CI.
- The chosen stack needs no API keys (OSM tiles), which is deliberate — see [ADR-0007](docs/adr/0007-flutter-map-over-google-maps.md).
- Location data never leaves the device in v1. Any future network use requires an ADR and a privacy note in the README.

## 9. Definition of done

A task is done when it is merged, tested, documented, demoable, and posted about if user-visible. "Works on my machine" is the start of done, not the end.
