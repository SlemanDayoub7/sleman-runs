# ADR-0006 — GPS stack: geolocator + foreground task

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

Live tracking must keep recording with the screen off for runs up to ~3 hours, on Android 12+ (v1 is Android-only, see [ADR-0012](0012-android-only-v1.md)), without draining the battery. Background location on Android requires a foreground service with a persistent notification, an explicit service type from Android 14, and a clear permission rationale for Play review.

## Decision

- **`geolocator`** for permissions, settings checks, and the position stream (only maintained, well-supported option with a single API across platforms).
- **`flutter_foreground_task`** for the Android foreground service and the persistent notification (distance, time, pause action).
- **iOS (deferred, not in v1):** when added, requires `UIBackgroundModes: location`, `NSLocationWhenInUseUsageDescription` and `NSLocationAlwaysAndWhenInUseUsageDescription`, with rationale text in both EN and AR. See [ADR-0012](0012-android-only-v1.md).
- Sampling: `LocationAccuracy.best` with `distanceFilter: 5 m` while active; drop to `high` when the app is backgrounded.
- All location access goes through `LocationDataSource`; nothing above `data` imports `geolocator`. This keeps the whole tracking feature testable with a fake stream.

Android specifics:

- `ACCESS_FINE_LOCATION` + `ACCESS_COARSE_LOCATION` + `FOREGROUND_SERVICE` + `FOREGROUND_SERVICE_LOCATION` + `POST_NOTIFICATIONS`.
- Foreground service type `location` declared in the manifest (required from Android 14).
- Battery optimisation exemption is suggested, never forced.

## Alternatives considered

- **`flutter_background_geolocation`:** the most reliable option, purpose-built, includes motion detection and crash recovery. Rejected for v1 because release builds require a paid license — a real constraint worth stating publicly.
- **`background_locator_2`:** less maintained, community forks diverge.
- **`workmanager`:** periodic, minutes-level granularity, unusable for a continuous track.
- **Rolling my own platform channels:** real learning, weeks of cost, no product value.

## Consequences

- Permission UX becomes a first-class flow: rationale screen → request → denied → settings deep link. Tested on a real device, not an emulator.
- Two plugins to keep in sync with platform policy changes; tracked in Dependabot.
- Battery behaviour must be measured on a mid-range Android device, not a flagship.
