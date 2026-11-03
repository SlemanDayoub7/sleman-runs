# Design system

One source of truth for color, type, spacing and motion, so dark mode, RTL and new screens are configuration rather than decoration.

All tokens live in `lib/app/theme` and are exposed through `ThemeExtension`s. Widgets read `Theme.of(context).extension<AppColors>()!` — never a raw hex value.

---

## 1. Color

Seed: **Ember** `#FF5A3C` — energy, visibility on a map, and a strong contrast against neutral ink. Accent **Volt** `#C8F135` is reserved exclusively for personal records and achievements, so it keeps its meaning.

### Core palette

| Token | Light | Dark | Use |
| --- | --- | --- | --- |
| `primary` | `#E8452A` | `#FF7A5F` | Primary actions, active nav, live run |
| `onPrimary` | `#FFFFFF` | `#2B0A03` | Text/icons on primary |
| `primaryContainer` | `#FFE3DC` | `#5A1A0C` | Selected chips, subtle fills |
| `accent` (PR) | `#6C8A00` | `#C8F135` | Records, achievements only |
| `background` | `#F7F8FA` | `#0B0F14` | App background |
| `surface` | `#FFFFFF` | `#12171F` | Cards, sheets |
| `surfaceVariant` | `#EDEFF3` | `#1B222C` | Inputs, dividers |
| `outline` | `#D3D8E0` | `#2C3542` | Borders |
| `textPrimary` | `#101419` | `#F2F5F8` | Titles, numbers |
| `textSecondary` | `#5A6472` | `#9AA6B5` | Labels, metadata |
| `success` | `#12855A` | `#3DDC97` | Goal met, saved |
| `warning` | `#B45309` | `#FBBF24` | Weak GPS, low battery |
| `error` | `#C02626` | `#FF6B6B` | Failures |
| `gpsLocked` | `#0E7490` | `#22D3EE` | Signal acquired |

Contrast: every text token is verified at ≥ 4.5:1 on its paired surface (≥ 3:1 for large numerals). The check is automated in `test/theme/contrast_test.dart`.

### Pace zones (data-driven, used in charts and splits)

| Zone | Range | Light | Dark |
| --- | --- | --- | --- |
| Recovery | > 7:30 /km | `#7C8B9E` | `#8C9AAD` |
| Easy | 6:15 – 7:30 | `#2E9E7E` | `#3DDC97` |
| Steady | 5:15 – 6:15 | `#2563C9` | `#60A5FA` |
| Threshold | 4:15 – 5:15 | `#C2760B` | `#FBBF24` |
| Interval | < 4:15 | `#C02626` | `#FF6B6B` |

---

## 2. Typography

**Manrope** for UI and headings (geometric, legible at small sizes), **JetBrains Mono** for timers, pace and splits. Tabular figures are mandatory anywhere a number changes, otherwise the layout jitters every second.

| Style | Size / line | Weight | Use |
| --- | --- | --- | --- |
| `displayMetric` | 56 / 60 | 700 mono, tabular | Live distance, timer |
| `h1` | 32 / 38 | 700 | Screen titles |
| `h2` | 24 / 30 | 600 | Section headers |
| `h3` | 19 / 26 | 600 | Card titles |
| `body` | 16 / 24 | 400 | Paragraphs |
| `label` | 14 / 20 | 500 | Buttons, tabs |
| `caption` | 12 / 16 | 500 | Metadata, units |

Arabic uses **IBM Plex Sans Arabic**; the font family is selected per locale in the theme. Line height increases by ~10% for Arabic.

---

## 3. Spacing, radius, elevation

- Spacing scale: `4, 8, 12, 16, 24, 32, 48` — no arbitrary values.
- Radius: `8` (inputs), `16` (cards), `24` (sheets), `999` (pills).
- Elevation: light uses tonal surfaces + `0.06` shadow; dark uses **no shadow** — contrast comes from surface lightness steps only (shadows are invisible on dark and cost frames).
- Screen gutter: `20`. Minimum touch target: `48×48`.
- Map is always full-bleed; content floats on a scrim, never in a boxed card over tiles.

---

## 4. Motion

| Token | Duration | Use |
| --- | --- | --- |
| `fast` | 150 ms | Ripples, chip selection |
| `base` | 250 ms | Page transitions, sheet open |
| `slow` | 400 ms | Metric updates, map camera moves |

- One easing curve: `Curves.easeOutCubic`. Consistency reads as quality.
- Live metrics animate by counting, not by rebuilding the whole tree — a `ValueListenableBuilder` around the numerals only.
- `MediaQuery.disableAnimations` is respected: durations collapse to zero.
- No decorative looping animation during a run (battery).

---

## 5. Icons and map

- `Material Symbols Rounded`, 24 dp, 1.75 stroke feel.
- Custom icons: start, pause, finish, auto-pause, GPS lock, split marker.
- Map: OSM tiles under a color filter (`ColorFiltered`) — light `none`, dark `invert + hue-rotate` approximation, documented as an approximation until a vector provider is chosen (see [ADR-0007](adr/0007-flutter-map-over-google-maps.md)).
- Route polyline: 5 px, `primary`, round caps; shadow pass at 12% opacity for readability over light tiles.

---

## 6. RTL rules

| Element | Mirrors? | Notes |
| --- | --- | --- |
| Layout, padding, alignment | Yes | Use `EdgeInsetsDirectional`, `start`/`end` |
| Back/forward chevrons | Yes | `Icons.arrow_back` → `arrow_forward` in RTL |
| Timers, pace, distance | No | Force LTR text direction |
| Map | No | Geography is not directional; controls flip |
| Charts | Yes | Time flows start→end in reading direction |
| Waveform-style charts | Yes | — |
| Phone numbers, emails, URLs | No | Force LTR |

Test matrix: `en` light, `en` dark, `ar` light, `ar` dark for every screen. Goldens catch the 90% case; a device pass catches the rest.

---

## 7. Voice and copy

- Direct, second person, no exclamation marks: "Start your run", not "Let's go!!".
- Numbers always with units: "5.2 km", "5:42 /km".
- Errors say what happened and what to do: "GPS signal lost. Move to open sky or pause your run."
- Empty states teach: "No runs yet. Your first 5K starts here." with a single action.
- Arabic is written, not translated word-for-word; sports terms use common Egyptian/Levantine usage and are reviewed by a native speaker.

---

## 8. Accessibility

- Contrast ≥ 4.5:1 for text, ≥ 3:1 for UI boundaries.
- Never color alone: pace zones carry a label, PRs carry an icon.
- Live metrics expose `Semantics(liveRegion: true)` and announce at most every 30 s.
- Visible focus rings in both themes.
- Text scaling to 200% without clipping: all metric cards use `FittedBox` or wrap.
- Haptics on start/pause/finish, with a settings toggle.
