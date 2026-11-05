# Changelog

All notable changes to this project are documented here.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versioning: [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-11-05

First public snapshot: Week 1 foundation and Week 2 design system.

### Added

#### Week 2 — design system

- Semantic colour tokens (`AppColors`) and pace-zone tokens (`PaceColors`) as `ThemeExtension`s, with WCAG contrast tests for both themes.
- Four cached `ThemeData` variants (`en`/`ar` × light/dark) and one global component theme covering app bar, buttons, navigation bar, cards, chips, inputs, dialogs, sheets, snackbars, tabs, switches, progress and tooltips.
- Bundled OFL fonts: Manrope and JetBrains Mono (variable) for Latin and metrics, IBM Plex Sans Arabic (static weights) for Arabic; Arabic prose gets +10% line height and the mono metric stays LTR.
- Static design tokens for spacing, size, radius and motion; `AppMotion.resolve` collapses durations when reduced motion is requested.
- Context extensions: `context.appColors`, `context.paceColors`, `context.textTheme`, `context.l10n`, `context.window`, `context.isRtl`.
- Shared widget layer: `AppText` (roles + tones, no arbitrary styles), `AppIcon`, `AppScaffold`, `AppButton`, `AppCard`, `AppSectionHeader`, `AppEmptyState`, `AppErrorView`, `AppBadge`, `AppSkeleton`, `AppMetric`, `AppChoiceChip`.
- Failure-to-copy mapping (`FailureCode` → ARB) so presentation never invents error strings.
- Responsive width classes (`compact`/`medium`/`expanded`), 20/24 dp gutters, a 600 dp content cap and a full-bleed escape hatch. Portrait is requested on phones; the layout remains usable when Android 16 ignores the lock.
- Tracking, history, plan, settings and the router error screen migrated to the design system; the temporary placeholder page is gone.
- Widget tests for every shared widget, a 96-combination responsive matrix (3 widths × 2 text scales × 4 variants × 4 screens), and 16 pixel goldens.
- Windows CI golden job; pixel comparison is opt-in locally via `RUN_GOLDENS=1`.
- ADR-0014 (portrait/responsive) and ADR-0015 (bundled fonts); DESIGN, ARCHITECTURE, TESTING and ROADMAP updated.
- `PERFORMANCE.md`, `GITHUB_SETUP.md` and `THIRD_PARTY_NOTICES.md`.

#### Week 1 — foundation

- Android scaffold on Flutter 3.41: feature-first clean architecture (`core`, `app`, `features`, `shared`), `very_good_analysis` with strict casts/inference, and `dependency_validator` in CI.
- Android toolchain aligned with the locally installed Gradle 8.10.2 and NDK 27.0.12077973, so a fresh build needs no extra downloads.
- English and Arabic localisation via ARB files, including RTL layout tests.
- `go_router` shell with four destinations, an explicit `get_it` composition root, and persisted theme/language settings.
- CI quality gate: formatting, analysis, dependency validation, tests, and a debug APK build; weekly Dependabot updates.
- Repository bootstrap: README, architecture document, 13 ADRs (including the reversal that dropped the web target, the Android-only scope and the optional Supabase backend), roadmap, testing strategy, design system and content plan.
- Contribution workflow: branching model, commit convention, PR and issue templates, code owners.
- MIT license.

### Changed

- App theme selection is a lookup of four pre-built themes instead of rebuilding `ThemeData` per frame.
- Every screen now renders through `AppScaffold`, so gutters, safe area and the content cap cannot drift per feature.
- Settings uses wrapping choice chips instead of a segmented control, which survives 200% text scaling and Arabic on a 320 dp phone.

### Fixed

- Navigation labels and app-bar titles that share a word (`Track`, `Settings`) no longer make widget-test finders ambiguous.

[Unreleased]: https://github.com/SlemanDayoub7/sleman-runs/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/SlemanDayoub7/sleman-runs/releases/tag/v0.2.0
[0.1.0]: https://github.com/SlemanDayoub7/sleman-runs/releases/tag/v0.1.0
