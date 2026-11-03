# ADR-0004 — Offline-first with Drift

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

A running app is used outdoors, in tunnels, on mountains, with no signal — and a run recorded at 3 km must not disappear because the app was killed. "Offline support" is usually bolted on later and is expensive. There is no backend in v1.

## Decision

**Local SQLite via `drift` is the source of truth.** The app is offline-first by construction: no feature requires a network.

Schema essentials:

- `run_sessions` — id, started_at, finished_at, distance_m, duration_s, status, goal, notes, rpe, `updated_at`, `deleted_at`, `sync_state`
- `track_points` — session_id, sequence, lat, lng, altitude, accuracy, speed, recorded_at (indexed by session)
- `splits` — session_id, index, distance_m, duration_s, elevation_gain
- `plans` / `plan_days` — generated training plan and completion state
- `sync_queue` — pending local mutations for v2

`drift` is chosen over raw `sqflite` for type-safe queries, generated DAOs, migrations, and in-memory test databases. Track points are written in batches every 5 s so a crash costs at most a few seconds of a run.

## Alternatives considered

- **`hive` / `isar`:** fast key-value, but weak relational queries (splits, weekly aggregates) and no SQL for stats. Isar's maintenance status is also a risk.
- **`sqflite` raw:** no type safety, hand-written mapping, slower to build.
- **`shared_preferences`:** wrong tool for time-series data.
- **Remote-first with local cache:** requires a backend in v1 and makes the crash-safety story worse.

## Consequences

- Stats and history are SQL queries, not client-side loops.
- No web target ([ADR-0011](0011-no-web-target.md)), so no `sqlite3.wasm`, no worker assets, and one less persistence path to maintain.
- Migration discipline required from day one; every schema change ships a migration test.
- v2 sync becomes additive: same ports, one extra data source.
