# Roadmap

Eight weeks, one milestone per week, one shippable slice each. GPS is in v1, which is why there are eight weeks and not six.

**Definition of done for every milestone:** merged to `main`, CI green, tests for new domain logic, docs/ADR updated, demoable, and a post published.

---

## Milestones

| Milestone | Week | Outcome | Exit criteria |
| --- | --- | --- | --- |
| `v0.1-foundation` | 1 | Project skeleton | `flutter run` on Android + iOS, theme toggle, EN/AR switch, 4 empty tabs |
| `v0.2-design-system` | 2 | Tokens and components | Light/dark/RTL golden tests, shared widgets, no hardcoded colors or strings |
| `v0.3-data-layer` | 3 | Offline storage | Drift schema + migrations, repositories, in-memory DB tests, seeded demo data |
| `v0.4-gps-core` | 4 | Acquisition and filtering | Permission flow, GPS stream, filter, live distance/time on screen |
| `v0.5-live-run` | 5 | Full tracking | Map + polyline, auto-pause, splits, foreground notification, crash recovery |
| `v0.6-history` | 6 | Run log | List, detail with route map, edit notes/RPE, delete with undo |
| `v0.7-insight` | 7 | Stats, plans and the pitch | Weekly volume, streaks, plan generator, pace calculator, 60-second demo video + README GIF |
| `v1.0-launch` | 8 | Release | Accessibility pass, performance pass, store assets, tag, retro post |

---

## Week 1 — Foundation

- [ ] `flutter create` with `--org com.sleman`, package `sleman_runs`, platforms android/ios (no web, per [ADR-0011](adr/0011-no-web-target.md))
- [ ] Folder skeleton per [ARCHITECTURE § 2](ARCHITECTURE.md#2-folder-map)
- [ ] `very_good_analysis`, strict `analysis_options.yaml`, `dependency_validator`
- [ ] Theme: `ColorScheme.fromSeed`, `AppThemeExtension`, light/dark/system, persisted
- [ ] `go_router` shell with 4 destinations (Track, History, Plan, Settings)
- [ ] l10n: `app_en.arb`, `app_ar.arb`, RTL verified in both themes
- [ ] `get_it` modules + resolve-all smoke test
- [ ] CI: format, analyze, test, build APK on PR
- [ ] `main` protected, PR template, issue templates, labels, Dependabot

**Posts 03–04:** "I built the theme and RTL switch before the first feature. Here's why."

## Week 2 — Design system

- [ ] Type scale with tabular figures for pace/time
- [ ] Buttons, cards, chips, empty states, error views, skeleton loaders
- [ ] Motion tokens (150/250/400 ms, one easing curve) with reduced-motion support
- [ ] Golden tests for 6 key components in light/dark/AR
- [ ] Icon set and map style constants

**Post 05:** carousel on design tokens in Flutter (`ThemeExtension` vs `if (isDark)`).

## Week 3 — Data layer

- [ ] Drift tables: `run_sessions`, `track_points`, `splits`, `plans`, `plan_days`, `sync_queue`
- [ ] Migration 1 with a migration test
- [ ] Domain entities with `freezed`, mappers from rows
- [ ] `RunRepository` (reader/writer split), `PlanRepository`
- [ ] Use cases: `CreateRun`, `SaveRun`, `WatchRuns`, `DeleteRun`, `GetWeeklyStats`
- [ ] Seed script for demo data (20 runs over 12 weeks)

**Posts 07–08:** "Offline-first isn't a feature, it's a constraint" — schema + sync-queue design.

## Week 4 — GPS core

- [ ] `LocationDataSource` wrapping `geolocator` behind an interface
- [ ] Permission flow: rationale → request → denied → open settings
- [ ] `GpsFilter` (accuracy, speed sanity, duplicate suppression) + unit tests
- [ ] `DistanceCalculator` (haversine, elevation gain) + tests against recorded GPX
- [ ] `TrackingCubit` state machine: idle → acquiring → active → paused → finished
- [ ] Live metrics UI (no map yet), wakelock while active

**Posts 09–10:** "The three lines of math that make a running app" — with real GPX data.

## Week 5 — Live run

- [ ] `flutter_map` with polyline, position marker, follow camera
- [ ] `flutter_foreground_task` notification with pause/resume actions
- [ ] Auto-pause detector (speed < 0.5 m/s for 10 s) + manual pause
- [ ] Splits per km/mile with elevation
- [ ] Incremental persistence every 5 s + `RecoverSession` on cold start
- [ ] Device testing: 5 km walk, screen off, airplane-mode spot checks
- [ ] Battery measurement log in `docs/perf/`

**Posts 11–12:** "I killed the app mid-run to test crash recovery. It worked — second try."

## Week 6 — History

- [ ] Run list grouped by week, virtualized
- [ ] Run detail: route map, splits chart, pace zones, notes, RPE
- [ ] Edit and delete with undo (soft delete + tombstone)
- [ ] Filter by distance/date, empty and error states
- [ ] Deep link `/runs/:id`

**Posts 13–14:** reel — scroll the history, open a run, edit a note.

## Week 7 — Insight + demo

- [ ] Weekly volume bar chart, streak logic (with unit tests), PR detection
- [ ] Training plan strategies: 5K beginner, 10K intermediate, half marathon
- [ ] Pace calculator (split table, negative split, finish-time predictor)
- [ ] Record the 60-second demo: real device, screen recording, captions, no talking head
- [ ] README GIF (5 s loop: start run → map draws → finish → history)
- [ ] APK signed and attached to the GitHub Release with install instructions
- [ ] Accessibility: semantics, 48 dp targets, contrast, screen-reader pass

**Posts 15–17:** "Why my app has no web demo" + the SOLID table as a carousel.

## Week 8 — Launch

- [ ] Performance: startup trace, frame timings, image/tile caching
- [ ] App icon, splash, store screenshots (EN + AR), feature graphic
- [ ] `CHANGELOG.md`, tag `v1.0.0`, GitHub Release with notes
- [ ] 3-minute demo video, case study PDF
- [ ] Retro post: metrics, mistakes, what's next
- [ ] Update LinkedIn featured section and CV

**Posts 18–20:** launch post + "8 weeks, 1 app, what I learned" thread.

---

## Issue breakdown

Epics map 1:1 to milestones. Issues are small enough to close in a day or two.

| Label | Meaning |
| --- | --- |
| `epic` | Milestone-level container |
| `feat` | User-visible functionality |
| `fix` | Defect |
| `test` | Test coverage work |
| `docs` | Documentation or ADR |
| `ci` | Build, release, tooling |
| `design` | Visual or UX work |
| `perf` | Performance |
| `content` | Post, video, screenshot |
| `good first issue` | Self-contained, documented |

Every issue uses the template: context, acceptance criteria, out-of-scope, screens.

## Risks

| Risk | Likelihood | Mitigation |
| --- | --- | --- |
| Background GPS flakiness on OEM Android skins | High | Test on a mid-range device early (Week 4, not Week 7); document findings |
| Scope creep into social features | High | Anything not in this file goes to `v2` in the backlog, no exceptions |
| GPS work eats content schedule | Medium | Batch-record content on Sundays; posts can trail the code by days |
| No link a recruiter can click and try | High | 60 s video + README GIF + APK release + QR code; the video does the work a demo link would |
| Arabic copy quality | Medium | Native review before Week 8; keep strings short and test with real text length |
