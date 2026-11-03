# ADR-0008 — Localization and RTL

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

The app must support English and Arabic, including full right-to-left layouts. Arabic was chosen deliberately: it is the hardest common case (RTL, six plural forms, digit shaping) and therefore proves the localization work is real rather than decorative.

## Decision

`flutter_localizations` + ARB files + generated accessors (`flutter gen-l10n`), with `intl` for dates, numbers and plurals.

- Source of truth: `lib/app/l10n/app_en.arb` (template) and `app_ar.arb`. Missing keys fail CI.
- No user-facing string literals in widgets; a lint rule and review checklist enforce it.
- Layout uses logical properties (`start`/`end`, `EdgeInsetsDirectional`), never `left`/`right`.
- Numbers, paces, timers and map labels stay LTR inside RTL contexts.
- Plural forms are declared per language in ARB, so Arabic gets zero/one/two/few/many/other.
- Locale is user-selectable (system / English / العربية) and persisted in settings.
- Units (km/mi) are a separate preference — do not infer them from locale.

## Alternatives considered

- **`easy_localization`:** simpler API, JSON-based, but a smaller ecosystem and it bypasses the official toolchain that hiring teams expect.
- **`slang`:** excellent type safety and codegen. Rejected for familiarity and because the official ARB path is what most Flutter teams use.
- **English only for v1:** fastest, but drops the single most visible differentiator in a demo and a strong talking point.

## Consequences

- Every new string touches two files; the build fails if one is forgotten.
- RTL bugs surface late in screenshots — mitigated by an RTL golden test per screen.
- Arabic copy needs a native review pass before launch, especially sports terminology.
