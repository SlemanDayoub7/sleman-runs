# ADR-0001 — Record architecture decisions

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

This project is built in public and doubles as a portfolio. The reasoning behind a choice is more valuable to a reviewer than the choice itself, and future-me will not remember why `flutter_map` beat Google Maps in week 2.

## Decision

Every significant, hard-to-reverse decision gets a numbered ADR in `docs/adr`, written in the same pull request that implements it. Format: status, date, context, decision, alternatives considered, consequences.

An ADR is superseded, never deleted. Superseded ADRs get a status line pointing at the replacement.

Significant means: framework or package choice, architectural boundary, data model, external dependency, or anything a new contributor would question.

## Consequences

- Decisions are reviewable and linkable from PRs and posts.
- Slight overhead per decision, paid once.
- The ADR folder becomes a ready-made content source and interview aid.
