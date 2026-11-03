# Changelog

All notable changes to this project are documented here.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versioning: [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Android scaffold on Flutter 3.41: feature-first clean architecture (`core`, `app`, `features`, `shared`), `very_good_analysis` with strict casts/inference, and `dependency_validator` in CI.
- Design tokens for light and dark themes, with WCAG contrast tests for every text token.
- English and Arabic localisation via ARB files, including RTL layout tests.
- `go_router` shell with four destinations, an explicit `get_it` composition root, and persisted theme/language settings.
- CI quality gate: formatting, analysis, dependency validation, tests, and a debug APK build; weekly Dependabot updates.
- Repository bootstrap: README, architecture document, 12 ADRs (including the reversal that dropped the web target and the Android-only scope), roadmap, testing strategy, design system and content plan.
- Contribution workflow: branching model, commit convention, PR and issue templates, code owners.
- MIT license.

[Unreleased]: https://github.com/SlemanDayoub7/sleman-runs/commits/main
