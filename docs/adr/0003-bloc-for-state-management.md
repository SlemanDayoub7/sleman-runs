# ADR-0003 — Bloc/Cubit for state management

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

Live tracking is a long-running, event-driven state machine (idle → acquiring → active → paused → finished → saved) that must survive navigation and backgrounding. The state solution has to be testable without a widget tree and understandable to a reviewer in five minutes.

## Decision

`flutter_bloc` with **Cubit** for screen state and **Bloc** only where events need ordering or debouncing (tracking). Explicit, immutable, sealed state classes via Dart 3 `sealed`.

```dart
sealed class TrackingState extends Equatable { ... }
```

Guidelines:

- One Cubit per screen-level concern, not per widget.
- States are value objects; never expose `TrackPoint` lists to the UI raw — expose a view model.
- Business logic stays in domain use cases; Cubits orchestrate and map results to states.
- No `BuildContext` inside a Cubit. No navigation from a Cubit; the UI reacts to states.

## Alternatives considered

- **Riverpod:** excellent, less boilerplate, better compile-time safety. Rejected because agencies and Flutter job listings in this market overwhelmingly ask for Bloc, and the goal here includes employability.
- **Provider + ChangeNotifier:** fine for small apps, poor for a 6-state machine and painful to test.
- **setState + services:** not defensible for a portfolio piece.
- **MobX:** codegen magic, harder to explain in an interview.

## Consequences

- Verbose state classes — mitigated by `freezed`.
- Trivially testable with `bloc_test`: emit sequences, no pumping widgets.
- Recruiters see the stack they actually use.
