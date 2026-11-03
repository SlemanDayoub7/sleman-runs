# Testing strategy

The goal is not a coverage number. It is **confidence in the parts that are hard to check by hand**: GPS math, session state transitions, and persistence durability. A GPS bug that only appears after 4 km on a real device cannot be debugged from a screenshot.

---

## Pyramid

| Layer | What | Tool | Target |
| --- | --- | --- | --- |
| Unit — domain | Filtering, distance, splits, pace, streaks, plan generation | `test`, `mocktail` | 90% |
| Unit — cubit | State sequences for every transition | `bloc_test` | 85% |
| Data | Repositories and DAOs against a real in-memory Drift DB | `drift/native.dart` | 80% |
| Widget | Key screens render in 4 modes (en/ar × light/dark) | `flutter_test`, goldens | smoke + goldens |
| Integration | Start → run → finish → history, with fake GPS | `integration_test` | happy path + recovery |

CI runs everything except device integration tests; those run locally before each milestone tag.

---

## 1. Unit tests that earn their keep

### `GpsFilter`

Given a stream of `GpsFix`, assert which fixes are accepted.

| Case | Input | Expected |
| --- | --- | --- |
| Poor accuracy | accuracy 60 m | rejected, `RejectReason.accuracy` |
| Teleport | 400 m in 3 s | rejected, `RejectReason.speed` |
| Duplicate | same coords, 400 ms later | rejected, `RejectReason.duplicate` |
| Normal walk | 5 m, accuracy 6, 3 s | accepted |
| Tunnel gap | 90 s gap, 300 m away | accepted, flagged `hasGap` |

### `DistanceCalculator`

- Haversine against known city pairs (assert within 1 m).
- Elevation gain ignores noise below 0.5 m and does not double-count descents.
- Splits: a 10.4 km track produces 10 full splits + a 0.4 km partial, summing back to total distance (property test).

### Fixtures

Recorded tracks in `test/fixtures/gpx/`:

- `easy_5k_clean.gpx` — open road, good signal
- `city_10k_canopy.gpx` — buildings, reflections, drift
- `trail_half_gap.gpx` — long signal loss
- `walk_intervals.gpx` — stop/start for auto-pause

A small GPX parser in `test/support/` turns them into `GpsFix` lists, so the same data drives filter, distance and auto-pause tests. This is the single most valuable test asset in the repo — and a good post.

### Determinism

No `DateTime.now()` in domain code. Everything takes a `Clock` (injected). Tests advance a `FakeClock` — no `sleep`, no flakiness.

---

## 2. Cubit tests

```dart
blocTest<TrackingCubit, TrackingState>(
  'emits acquiring then active when start succeeds',
  build: () => cubit,
  act: (c) => c.start(),
  expect: () => [isA<TrackingAcquiring>(), isA<TrackingActive>()],
);
```

Required cases: start with permission denied, start with GPS disabled, pause/resume, auto-pause trigger, finish with zero distance (must not save), finish during signal loss, recover unfinished session, failure during persist (state keeps last good metrics).

---

## 3. Data tests

- Real Drift database on a temp file via `NativeDatabase.memory()`, not mocks — SQL bugs hide behind mocks.
- Migration test: create a v1 database with fixture rows, run `onUpgrade`, assert data survives and columns default correctly.
- Batch write test: 10 000 track points insert under 1 s; query a session's points in order.
- Soft delete: deleted runs disappear from `watchRuns` but remain for sync.

---

## 4. Widget and golden tests

Goldens for: theme switch, live run screen, run detail, empty history, plan card, error state.

Each golden runs in `en-LTR-light`, `en-LTR-dark`, `ar-RTL-light`, `ar-RTL-dark` — 24 files. Reviewing a golden diff is how RTL overflow gets caught in seconds instead of at launch.

Fonts are loaded from `test/fonts/` so goldens are deterministic across machines.

---

## 5. Manual device checklist (before each tag)

- [ ] 5 km outdoor run, screen off, notification updates
- [ ] Kill app mid-run → reopen → recovery prompt restores the session
- [ ] Airplane mode mid-run → no crash, points buffered
- [ ] Deny permission → settings deep link works
- [ ] Arabic + dark mode: no clipped text on tracking, history, plan
- [ ] 200% text scale on tracking screen
- [ ] Battery: < 8% per hour of tracking on the test device
- [ ] Low-end Android: no dropped frames on the live screen (DevTools timeline)

Results go in `docs/perf/device-matrix.md` with device, OS and build hash. Numbers, not vibes.

---

## 6. CI gates

```bash
dart format --set-exit-if-changed .
flutter analyze --fatal-infos
flutter test --coverage
dart run dependency_validator
flutter build apk --debug
```

PRs cannot merge with a red check. Coverage is reported, not gated at a fixed number — a gate on a percentage rewards testing getters.

---

## 7. What we deliberately do not test

- Generated code (`*.freezed.dart`, `*.g.dart`, l10n).
- Third-party plugin internals; we test our wrapper's contract instead.
- Pixel-perfect goldens for the map (tile rendering is non-deterministic) — assert the polyline and markers exist instead.
