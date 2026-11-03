# ADR-0009 — get_it for dependency injection

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

Cubits need use cases, use cases need repositories, repositories need data sources, and the Drift database needs a single instance. Constructor injection is non-negotiable for testability; the question is only who wires it.

## Decision

`get_it` with **explicit, manual registration** split into modules (`registerCore`, `registerTracking`, `registerHistory`, ...), called from `bootstrap.dart`.

- `registerLazySingleton` for infrastructure (database, clock, logger, repositories).
- `registerFactory` for Cubits, so each screen gets a fresh instance.
- No `injectable` codegen: the registration file is the readable, greppable dependency graph and doubles as documentation.
- Tests never use the container; they construct the object graph by hand.

## Alternatives considered

- **`get_it` + `injectable`:** less boilerplate at scale, but generated code hides the graph and the annotation ceremony buys little at this size.
- **Riverpod providers as DI:** would mean two state solutions.
- **Manual constructor wiring in `main.dart`:** works until the shell router needs a Cubit three levels deep; the container is simpler for deep links and tests.
- **Service locator called inside classes (`GetIt.I<X>()`):** rejected outright — hidden dependencies are the thing DI exists to prevent.

## Consequences

- One file to read to understand the graph; one file to edit when adding a feature.
- Registration order bugs are possible — mitigated by a smoke test that resolves every registered type.
- Migrating to `injectable` later is mechanical if the project grows.
