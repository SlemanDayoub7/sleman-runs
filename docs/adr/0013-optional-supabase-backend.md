# ADR-0013 — Supabase as the optional backend, deferred to v2

- **Status:** Proposed
- **Date:** 2026-11-05
- **Related:** [ADR-0004](0004-offline-first-with-drift.md), [ADR-0012](0012-android-only-v1.md)

## Context

v1 is deliberately backend-free. Runs, track points and plans live in a local Drift database, which is what makes the app useful on a treadmill in a basement and keeps the eight-week scope honest.

The next product step after v1 is optional: signing in on a new phone and finding your history, or sharing a run. That needs an account, a remote database and a sync story. The likely choice is Supabase — Postgres, row-level security, email/OAuth sign-in and object storage in one platform — but nothing in v1 should depend on that decision being final.

No backend can be added later without three constraints being true from day one:

1. Primary keys are client-generated UUIDs, not auto-increment integers.
2. Every mutable row can record `updated_at` and a sync state.
3. Remote access sits behind a repository interface, never inside a widget or a use case.

## Decision

**If a backend is added, it will be Supabase, and it starts in v2.**

- **v1 has no network dependency.** No Supabase SDK, no login screen, no remote schema. The app must pass all tests and ship with the device in airplane mode.
- **v2 scope:** Supabase Auth for sign-in, Postgres tables mirroring the local schema, Storage for optional route images, and a replay of the local `sync_queue` on reconnect.
- **Isolation:** a `SupabaseSyncDataSource` implements a `SyncRepository` port. The domain layer imports neither Supabase nor HTTP types. Supabase stays in `data`/`infrastructure`, next to Drift.
- **Security:** row-level security on every table, keyed by `auth.uid()`. Only the publishable (anon) key ships in the app; anything privileged goes through an Edge Function.
- **Conflict policy:** track points are append-only, so they merge by UUID. Notes and preferences use last-write-wins by `updated_at`, with the losing value kept locally for one sync cycle rather than discarded silently.
- **Deletion:** soft deletes locally with a tombstone, so a deletion can be replayed instead of resurrecting a run on the next sync.

## Alternatives considered

- **Firebase:** strong mobile SDKs, but a document model would force a second schema and weaker relational queries for splits and weekly volume. Supabase keeps one SQL-shaped mental model for local and remote.
- **Custom API (NestJS/FastAPI + Postgres):** more control and a better "backend engineer" signal, but it adds deployment, backups, migrations and monitoring — weeks that v1 does not have. Could still be swapped in behind `SyncRepository`.
- **No backend, ever:** simplest and fastest, but rules out multi-device history and social features. Acceptable for v1, not for the 12-month product.
- **Supabase in v1 (auth at launch):** rejected. It adds failure states (offline login, token refresh, account deletion) before the core GPS loop is proven, and would make the first release depend on a service the product does not need yet.

## Consequences

- v1 ships sooner and stays testable without mocks of a remote service.
- The Week 3 Drift schema must use UUID primary keys and include `sync_queue`; that is already in the roadmap, and this ADR makes it non-negotiable.
- v2 can be built without touching the domain layer: add a data source, implement the port, replay the queue.
- The public story is honest: "offline-first now, optional Supabase sync later" rather than a backend that exists only in a diagram.
- If Supabase is dropped, the cost is one data-source file, not a rewrite.
