# Sleman Runs

> An offline-first running app built in public — clean architecture, Bloc, SOLID, dark/light, English + Arabic.

**Status:** 🚧 Week 0 — architecture and decisions first, code starts next.

Sleman Runs tracks your runs with live GPS, turns them into splits and weekly volume, and keeps working when your signal doesn't. It is also a public engineering journal: every architectural decision, trade-off and mistake is documented here, in `docs/adr`, and in the build-in-public series.

---

## Why this repo exists

Most portfolio apps are a UI with a `main.dart`. This one is the opposite: the product is small on purpose, and the engineering around it is the deliverable.

- **Architecture you can navigate** in ten seconds — feature-first clean architecture, one dependency direction.
- **Decisions you can defend** — every non-obvious choice has an ADR with the alternatives that were rejected.
- **Tests that mean something** — the GPS filter and distance math are pure Dart and tested against recorded tracks.
- **A repo that looks like a team's** — protected `main`, short-lived branches, conventional commits, PR template, CI, releases, changelog.
- **A story you can follow** — every week ships something and is posted about.

## Product scope

| Version | Scope |
| --- | --- |
| **v0.1** | Repo, docs, design tokens, theme system, l10n (EN/AR + RTL), router, DI |
| **v0.5** | Live GPS tracking, map, auto-pause, crash-safe session recovery |
| **v0.8** | Run history, splits, stats dashboard, training plans, pace calculator |
| **v1.0** | Polish, accessibility, demo video, store-ready build |
| **v2.0** | Account + sync, friend activity, offline queue replay |

Deliberately out of scope for v1: social feed, wearable sync, AI coaching, payments.

**Platform:** Android 8.0+ (API 26). iOS is deferred, not ruled out — [ADR-0012](docs/adr/0012-android-only-v1.md). There is no web build at all — [ADR-0011](docs/adr/0011-no-web-target.md).

## Stack

| Concern | Choice | Decision |
| --- | --- | --- |
| State | `flutter_bloc` (Cubit) + sealed states | [ADR-0003](docs/adr/0003-bloc-for-state-management.md) |
| Architecture | Feature-first clean architecture | [ADR-0002](docs/adr/0002-feature-first-clean-architecture.md) |
| Navigation | `go_router`, typed routes | [ADR-0005](docs/adr/0005-go-router-for-navigation.md) |
| Local database | `drift` (SQLite) | [ADR-0004](docs/adr/0004-offline-first-with-drift.md) |
| GPS | `geolocator` + `flutter_foreground_task` | [ADR-0006](docs/adr/0006-live-gps-tracking-stack.md) |
| Maps | `flutter_map` + OpenStreetMap | [ADR-0007](docs/adr/0007-flutter-map-over-google-maps.md) |
| Localization | `flutter_localizations` + ARB + `intl` | [ADR-0008](docs/adr/0008-localization-and-rtl.md) |
| DI | `get_it`, explicit registration | [ADR-0009](docs/adr/0009-get-it-for-dependency-injection.md) |
| Errors | `fpdart` `Either<Failure, T>` | [Architecture § 6](docs/ARCHITECTURE.md#6-error-handling) |
| Models | `freezed` + `json_serializable` | — |
| Lints | `very_good_analysis` | — |
| Tests | `bloc_test`, `mocktail`, in-memory Drift | [TESTING.md](docs/TESTING.md) |

## Documentation

| Document | What's inside |
| --- | --- |
| [Architecture](docs/ARCHITECTURE.md) | Layers, folder map, dependency rule, SOLID map, data flows |
| [ADRs](docs/adr) | Every significant decision, with rejected alternatives |
| [Roadmap](docs/ROADMAP.md) | 8-week plan, milestones, issue breakdown, definition of done |
| [Testing](docs/TESTING.md) | Test pyramid, GPS fixtures, coverage targets |
| [Design](docs/DESIGN.md) | Design tokens, type scale, dark/light mapping, RTL rules |
| [Contributing](CONTRIBUTING.md) | Branching, commit convention, PR process, releases |
| [Content plan](docs/CONTENT_PLAN.md) | The build-in-public calendar and post templates |
| [Changelog](CHANGELOG.md) | Release history |

## Build in public

The series index lives here so the repo and the posts stay connected.

| # | Week | Topic | LinkedIn | Instagram |
| --- | --- | --- | --- | --- |
| 01 | 0 | Architecture before UI | _pending_ | _pending_ |
| 02 | 1 | Theme tokens & RTL | _pending_ | _pending_ |
| 03 | 2 | Offline-first with Drift | _pending_ | _pending_ |
| 04 | 3 | The GPS pipeline | _pending_ | _pending_ |
| 05 | 4 | Crash-safe run sessions | _pending_ | _pending_ |
| 06 | 5 | Stats without a backend | _pending_ | _pending_ |
| 07 | 6 | SOLID in real files | _pending_ | _pending_ |
| 08 | 7 | v1.0 launch & retro | _pending_ | _pending_ |

## Getting started

```bash
# after the app scaffold lands (Week 1)
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Minimum SDK: Flutter 3.41 / Dart 3.11.

## Try it

- 60-second demo video: _coming in Week 7_
- APK with live GPS: _coming in Week 5_
- Launch build: _coming in Week 8_

There is no web build. A browser tab cannot record a run with the screen off, and a demo that cannot do the one thing the app exists for is worse than no demo — see [ADR-0011](docs/adr/0011-no-web-target.md).

## License

MIT — see [LICENSE](LICENSE).

---

Built by **Sleman** · [LinkedIn](#) · [Instagram](#) · _open to Flutter roles — say hello._
