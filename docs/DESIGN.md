# Design system

One source of truth for colour, type, spacing and motion, so dark mode, RTL and new screens are configuration rather than decoration.

The system has three layers:

```text
tokens            static constants + ThemeExtensions      lib/app/theme
      │
      ▼
ThemeData         four cached variants (brightness × locale)
      │
      ▼
widgets           AppText, AppScaffold, AppButton, …       lib/shared/widgets
```

A feature reads tokens through `context.appColors`, `context.textTheme` and `context.l10n` — never a raw hex value, a `TextStyle` or a hardcoded string. See [ADR-0015](adr/0015-bundled-fonts.md) for the font decision and [ADR-0014](adr/0014-portrait-phones-responsive-layout.md) for the responsive rules.

---

## 1. Colour

Seed: **Ember** `#E8452A`. It generates the Material scheme; the semantic tokens below override the parts that carry product meaning. **Volt** `#C8F135` is reserved exclusively for personal records and achievements, so it keeps that meaning in every screen.

### Core palette

| Token | Light | Dark | Use |
| --- | --- | --- | --- |
| `primary` | `#D63F26` | `#FF7A5F` | Primary actions, active nav, live run |
| `onPrimary` | `#FFFFFF` | `#2B0A03` | Text/icons on primary |
| `primaryContainer` | `#FFE3DC` | `#5A1A0C` | Selected chips, subtle fills |
| `accent` (PR) | `#6C8A00` | `#C8F135` | Records, achievements only |
| `background` | `#F7F8FA` | `#0B0F14` | App background |
| `surface` | `#FFFFFF` | `#12171F` | Cards, sheets, navigation bar |
| `surfaceVariant` | `#EDEFF3` | `#1B222C` | Inputs, dividers, skeletons |
| `outline` | `#D3D8E0` | `#2C3542` | Borders and hairlines |
| `textPrimary` | `#101419` | `#F2F5F8` | Titles, numbers |
| `textSecondary` | `#5A6472` | `#9AA6B5` | Labels, metadata |
| `success` | `#0E7A4E` | `#3DDC97` | Goal met, saved |
| `warning` | `#B45309` | `#FBBF24` | Weak GPS, low battery |
| `error` | `#C02626` | `#FF6B6B` | Failures |
| `gpsLocked` | `#0E7490` | `#22D3EE` | Signal acquired |

Contrast: every text token is verified at ≥ 4.5:1 on its paired surface, and UI boundaries at ≥ 3:1. The check is automated in [`test/app/theme/contrast_test.dart`](../test/app/theme/contrast_test.dart), not left to review.

### Pace zones

Data colours, not surface colours. They appear in splits and charts and are never used for buttons, because they encode effort rather than interaction.

| Zone | Range | Light | Dark |
| --- | --- | --- | --- |
| Recovery | > 7:30 /km | `#7C8B9E` | `#8C9AAD` |
| Easy | 6:15 – 7:30 | `#2E9E7E` | `#3DDC97` |
| Steady | 5:15 – 6:15 | `#2563C9` | `#60A5FA` |
| Threshold | 4:15 – 5:15 | `#C2760B` | `#FBBF24` |
| Interval | < 4:15 | `#C02626` | `#FF6B6B` |

`PaceColors` is a separate `ThemeExtension` so a chart cannot accidentally use a pace colour for a tap target.

### Tones

Widgets do not accept a `Color` for foregrounds. They accept an `AppTone`:

```dart
enum AppTone { primary, secondary, error, success, warning, accent, onPrimary, disabled }
```

`AppText`, `AppIcon` and `AppBadge` resolve the tone against the current `AppColors`. Swapping themes changes the colour; it cannot change the meaning.

---

## 2. Typography

Three bundled OFL families, selected per locale:

- **Manrope** (variable) — Latin UI and headings.
- **JetBrains Mono** (variable) — timers, pace, splits. Tabular figures are mandatory anywhere a number changes.
- **IBM Plex Sans Arabic** (static 400/500/600/700) — Arabic UI.

| Role | Size / line | Weight | Use |
| --- | --- | --- | --- |
| `metric` | 56 / 60 | 700 mono, tabular | Live distance, timer |
| `h1` | 32 / 38 | 700 | Screen titles |
| `h2` | 24 / 30 | 600 | Section headers, empty-state titles |
| `h3` | 19 / 26 | 600 | App bar, card titles |
| `body` | 16 / 24 | 400 | Paragraphs |
| `label` | 14 / 20 | 500 | Buttons, tabs |
| `caption` | 12 / 16 | 500 | Metadata, units |

Rules:

- Weight is set through the variable-font `wght` axis for Manrope and JetBrains Mono, and through `fontWeight` for the static Arabic faces. Never both.
- Arabic line height is **+10%** for prose and headings, and unchanged for the mono metric.
- `AppText` is the only text widget. It takes a role and an optional tone; there is deliberately no arbitrary `style` parameter, so a screen cannot invent a sixteenth size.
- `AppText.metric` forces `TextDirection.ltr` and tabular figures even in Arabic. A number is data, not prose.

---

## 3. Spacing, size, radius, elevation

Tokens are plain constants, not `ThemeExtension`s: they do not change with brightness or locale, and putting them in a theme would make Flutter interpolate constants on every theme transition.

- **Spacing:** `4, 8, 12, 16, 24, 32, 48`. Gutter `20` compact, `24` wide. No arbitrary values.
- **Size:** minimum tap target `48`, content cap `600`, icons `16/24/32`, empty-state artwork `72`, hairline `1`.
- **Radius:** `8` inputs, `16` cards, `24` sheets, `999` pills.
- **Elevation:** cards and bars are **flat and bordered**. Contrast comes from surface steps and a 1 dp outline, not shadows: shadows are nearly invisible on dark and cost frames on every scroll.

---

## 4. Motion

| Token | Duration | Use |
| --- | --- | --- |
| `fast` | 150 ms | Ripples, chip selection |
| `base` | 250 ms | Page transitions, sheet open |
| `slow` | 400 ms | Metric updates, map camera moves |

- One easing curve: `Curves.easeOutCubic`. Consistency reads as quality.
- `AppMotion.resolve(context, duration)` collapses every duration to zero when `MediaQuery.disableAnimationsOf(context)` is true.
- Live metrics animate by counting around the numerals only, not by rebuilding the screen.
- No decorative looping animation during a run. `AppSkeleton` is deliberately static: a shimmer costs frames and battery for information the user can already infer.

---

## 5. Responsive layout

Width is the only layout signal. Orientation is not read anywhere, because Android 16 ignores portrait locks on displays ≥ 600 dp.

| Class | Width | Gutter | Content |
| --- | --- | --- | --- |
| `compact` | `< 600` | 20 | full width |
| `medium` | `600–839` | 24 | capped at 600 and centred |
| `expanded` | `>= 840` | 24 | capped at 600 and centred |

`AppScaffold` owns safe area, the gutter and the cap. `fullBleed: true` is for the map: it ignores the cap but still respects the status bar and cutouts.

Every screen is tested at `320`, `412` and `840 dp`, at `1.0` and `2.0` text scale, in all four theme variants. That matrix is `test/app/responsive/layout_matrix_test.dart`; it fails on overflow, a wrong text direction or a wrong brightness.

---

## 6. Theme construction

Four `ThemeData` objects are built once and cached: `lightEn`, `lightAr`, `darkEn`, `darkAr`. Locale is part of the variant because the font family and line height depend on the writing system, not only on brightness.

`app_component_theme.dart` themes Material once — app bar, buttons, navigation bar, cards, chips, inputs, dialogs, sheets, snackbars, tabs, switches, progress indicators, tooltips — so screens use standard Material controls and still look like the product. Wrapping every control in a custom widget would be a rebuild tax and a maintenance cost.

---

## 7. Component catalogue

| Widget | Responsibility |
| --- | --- |
| `AppText` | Role + tone. The only text widget. |
| `AppText.metric` | LTR, tabular numeric role. |
| `AppIcon` | Themed icon with a semantic tone. |
| `AppScaffold` | Safe area, gutter, content cap, full-bleed option. |
| `AppButton` | Filled/outlined/text button with async loading and full-width mode. |
| `AppCard` | Bordered surface with token padding and an optional tap target. |
| `AppSectionHeader` | Section title with an optional trailing action. |
| `AppEmptyState` | Artwork, title, body, one action; scrollable and height-aware. |
| `AppErrorView` | Maps a domain `Failure` to localised copy and a retry action. |
| `AppBadge` | Small status label; meaning carried by text, never colour alone. |
| `AppSkeleton` | Static loading placeholder, excluded from semantics. |
| `AppMetric` | Label + tabular value in a repaint boundary. |
| `AppChoiceChip` | Wrapping single-choice chip that survives large text. |

Screens compose these; they do not rebuild them per feature. If a screen needs a new variant, the variant belongs in the shared widget, not in a local `copyWith`.

---

## 8. Icons and map

- Material Icons, 24 dp, themed through `iconTheme`. Custom run icons (start, pause, finish, GPS lock, split) arrive with the tracking feature.
- Map: OSM tiles under a color filter — light `none`, dark `invert + hue-rotate` approximation, documented as an approximation until a vector provider is chosen (see [ADR-0007](adr/0007-flutter-map-over-google-maps.md)).
- Route polyline: 5 px, `primary`, round caps; a 12% shadow pass keeps it readable over light tiles. The map is full-bleed; controls float on a scrim, never in a card over tiles.

---

## 9. RTL rules

| Element | Mirrors? | Notes |
| --- | --- | --- |
| Layout, padding, alignment | Yes | `EdgeInsetsDirectional`, `start`/`end` |
| Back/forward chevrons | Yes | `Icons.arrow_back` → `arrow_forward` in RTL |
| Timers, pace, distance | No | `AppText.metric` forces LTR |
| Map | No | Geography is not directional; controls flip |
| Charts | Yes | Time flows in the reading direction |
| Phone numbers, emails, URLs | No | Force LTR |

Every golden runs in `en` light, `en` dark, `ar` light and `ar` dark. The width/scale matrix catches the rest.

---

## 10. Voice and copy

- Direct, second person, no exclamation marks: "Start your run", not "Let's go!!".
- Numbers always carry units: "5.2 km", "5:42 /km".
- Errors say what happened and what to do: "GPS signal lost. Move to open sky or pause your run."
- Empty states teach: "No runs yet. Your first 5K starts here." with one action.
- Arabic is written, not translated word-for-word; sports terms use common Egyptian/Levantine usage and are reviewed by a native speaker.
- Failures never carry user-facing strings. `FailureCode` maps to ARB copy in `lib/app/l10n/failure_messages.dart`.

---

## 11. Accessibility

- Contrast ≥ 4.5:1 for text, ≥ 3:1 for UI boundaries, enforced by tests.
- Never colour alone: pace zones carry a label, PRs carry an icon, badges carry text.
- Tap targets ≥ 48×48, themed globally.
- Text scaling to 200% without clipping, covered by the layout matrix at 320 dp.
- Live metrics expose one `Semantics` label and will announce at most every 30 s.
- Reduced motion is respected globally through `AppMotion`.
- Haptics on start/pause/finish, with a settings toggle (Week 5).

---

## 12. Testing the design system

| Test | What it protects |
| --- | --- |
| `test/app/theme/contrast_test.dart` | WCAG ratios for both themes |
| `test/app/theme/design_theme_test.dart` | Four cached variants, type scale, Arabic line height, component tokens |
| `test/shared/widgets/` | Roles, tones, loading, tap targets, failure copy, LTR metrics |
| `test/app/responsive/layout_matrix_test.dart` | Width × text scale × theme, all four screens |
| `test/goldens/` | 16 pixel baselines: 4 screens × 4 variants at 412 dp |

Goldens are opt-in locally and verified in CI on **Windows**, the platform they were generated on:

```bash
RUN_GOLDENS=1 flutter test --update-goldens test/goldens
RUN_GOLDENS=1 flutter test test/goldens
```

A normal `flutter test` skips pixel comparison but still runs every widget and layout test.
