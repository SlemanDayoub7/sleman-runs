# GitHub setup

The repository is ready to publish; the remote does not exist yet. This is the exact sequence, in order, so the first public state is green and protected rather than a pile of red checks.

> **Status:** `main` is local only. `gh` is not installed on the development machine, so step 1 can be done in the browser instead.

---

## 1. Create the repository

**Browser**

1. Go to <https://github.com/new>.
2. Owner: `SlemanDayoub7`. Name: `sleman-runs`. Visibility: **Public**.
3. Do **not** initialise with a README, `.gitignore` or licence — the repo already has all three.
4. Create the repository.

**`gh` CLI (once installed)**

```bash
gh repo create SlemanDayoub7/sleman-runs --public --source=. --remote=origin
```

---

## 2. Push `main` first

CI triggers on pushes to `main`, so this is also the first real check run.

```bash
git remote add origin https://github.com/SlemanDayoub7/sleman-runs.git
git push -u origin main
```

Then push the Week 2 branch:

```bash
git push -u origin feat/week-2-design-system
```

Open a pull request with the PR template. The branch is merged with `--no-ff` locally only until the PR flow exists; after this first push, use real pull requests.

---

## 3. Confirm both CI jobs are green

The workflow has three jobs:

| Job | Runner | What it proves |
| --- | --- | --- |
| `quality` | `ubuntu-latest` | Format, analyze, dependency graph, unit/widget tests, coverage artifact |
| `android` | `ubuntu-latest` | Debug APK builds end to end |
| `goldens` | **`windows-latest`** | Pixel baselines match the machine they were generated on |

The golden job is Windows on purpose: font rasterisation differs across operating systems, and a Linux runner would report false diffs for every baseline. Do not "fix" a golden by regenerating it on Linux.

If the golden job fails, download the `golden-failures` artifact, compare the images, and decide whether the UI changed. Regenerate only after accepting the change:

```bash
RUN_GOLDENS=1 flutter test --update-goldens test/goldens
```

Commit the PNGs with the code change that caused them.

---

## 4. Protect `main`

Settings → Branches → **Add branch protection rule** (or Rulesets):

- Branch name pattern: `main`.
- **Require a pull request before merging.**
- Required approvals: `1` (or `0` while working solo — keep the PR requirement).
- **Require status checks to pass before merging.** Select all three:
  - `Analyze and test`
  - `Build debug APK`
  - `Golden tests`
- **Require branches to be up to date before merging.**
- **Require conversation resolution before merging.**
- Do not allow force pushes or deletions.
- Apply the rule to administrators too if the goal is a real audit trail.

With a solo account, "require approvals" cannot be satisfied by the author, so either set approvals to `0` and rely on the status checks, or use a second account for reviews. Status checks are the useful gate here.

---

## 5. Labels

Create the labels used by the issue templates and roadmap:

```text
epic              #6E40C9
feat              #1D76DB
fix               #D73A4A
test              #0E8A16
docs              #0075CA
ci                #5319E7
design            #D4C5F9
perf              #FBCA04
content           #FF7619
good first issue  #7057FF
blocked           #B60205
```

CLI alternative:

```bash
gh label create epic --color 6E40C9 --description "Milestone-level container"
gh label create feat --color 1D76DB --description "User-visible functionality"
gh label create fix --color D73A4A --description "Defect"
gh label create test --color 0E8A16 --description "Test coverage work"
gh label create docs --color 0075CA --description "Documentation or ADR"
gh label create ci --color 5319E7 --description "Build, release, tooling"
gh label create design --color D4C5F9 --description "Visual or UX work"
gh label create perf --color FBCA04 --description "Performance"
gh label create content --color FF7619 --description "Post, video, screenshot"
gh label create "good first issue" --color 7057FF --description "Self-contained and documented"
gh label create blocked --color B60205 --description "Waiting on an external dependency"
```

---

## 6. Repository settings

- **About:** description *"Offline-first running app built in public — Flutter, Bloc, clean architecture."*
- **Topics:** `flutter`, `dart`, `android`, `clean-architecture`, `bloc`, `gps`, `offline-first`, `build-in-public`, `design-system`, `rtl`.
- **Features:** Issues on, Discussions on (for questions and weekly notes), Projects on if the roadmap is mirrored there.
- **Merge button:** allow squash and merge only; disable merge commits and rebase merges. The history stays linear and each PR is one conventional commit.
- **Dependabot:** already configured in `.github/dependabot.yml`; confirm alerts are on.
- **Security:** enable private vulnerability reporting; Dependabot security updates on.

---

## 7. First release

After Week 2 is merged:

```bash
git tag -a v0.2.0 -m "v0.2.0 — design system"
git push origin v0.2.0
```

Create a GitHub Release from the tag, attach `app-debug.apk` for now, and copy the relevant `CHANGELOG.md` section. The signed release APK and store assets arrive in Week 8.

Release notes must include the font licences link: [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

---

## 8. Publishing checklist

- [ ] Repository is public and named `sleman-runs`
- [ ] `main` pushed; CI has run at least once
- [ ] Week 2 PR merged through the PR flow
- [ ] All three checks required on `main`
- [ ] Labels applied
- [ ] About, topics and social preview image set
- [ ] Squash-only merges
- [ ] Dependabot alerts and security updates on
- [ ] `v0.2.0` tag and release published
- [ ] First build-in-public post links to the repo, not the reverse

The social preview image can wait for the Week 5 map screenshot; a plain Ember-on-ink card with the wordmark is enough for launch week.
