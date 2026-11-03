# ADR-0007 — flutter_map over Google Maps

- **Status:** Accepted
- **Date:** 2026-11-03

## Context

The live run screen and the run detail screen both need a map: a moving polyline, a current-position marker, and a fit-to-bounds view of a finished route. The app ships a free public web demo and has no backend and no budget.

## Decision

**`flutter_map` with OpenStreetMap raster tiles**, rendered behind the app's own map style.

- No API key, no billing account, no per-platform setup.
- Works identically on Android, iOS and web — the demo is one code path.
- `PolylineLayer` + `MarkerLayer` + `CameraFit.bounds` cover every requirement.
- Tile provider is injected, so swapping to a paid/styleable vector provider (MapTiler, MapLibre) later is a one-line change.

Attribution is displayed on the map as required by the OSM tile policy. For a public production launch, tile usage would move to a self-hosted or paid tile server; for a portfolio demo the standard usage policy is respected (caching, identifying user agent, no bulk downloading).

## Alternatives considered

- **`google_maps_flutter`:** best-looking maps and street data. Rejected for v1: API key management, billing, per-platform config, and flaky web support would consume days that belong to the GPS pipeline.
- **`maplibre_gl`:** vector tiles, great styling, but heavier setup and weaker web story.
- **Custom-painted canvas map:** impressive, but weeks of work for worse results.

## Consequences

- Zero cost and zero secrets in the repo, which also keeps CI simple.
- OSM raster styling is limited; the app's own dark map style is approximated with a color filter over tiles.
- Route: evaluate MapTiler before any store launch.
