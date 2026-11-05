# Third-party notices

Sleman Runs is MIT-licensed (see [LICENSE](LICENSE)). It bundles or depends on the following third-party work. The full text of every licence ships in the referenced file or package.

## Bundled fonts

All three families are licensed under the **SIL Open Font License 1.1**. The OFL permits use, modification and redistribution as part of a larger work, provided the licence text accompanies the font and the font is not sold on its own. The fonts are not modified: the `.ttf` files are the upstream releases.

| Family | Files | Copyright | Licence |
| --- | --- | --- | --- |
| **Manrope** | `assets/fonts/Manrope/Manrope[wght].ttf` | Copyright 2018 The Manrope Project Authors | [`assets/fonts/Manrope/OFL.txt`](assets/fonts/Manrope/OFL.txt) |
| **JetBrains Mono** | `assets/fonts/JetBrains_Mono/JetBrainsMono[wght].ttf` | Copyright 2020 The JetBrains Mono Project Authors | [`assets/fonts/JetBrains_Mono/OFL.txt`](assets/fonts/JetBrains_Mono/OFL.txt) |
| **IBM Plex Sans Arabic** | `assets/fonts/IBM_Plex_Sans_Arabic/IBMPlexSansArabic-{Regular,Medium,SemiBold,Bold}.ttf` | Copyright © 2017 IBM Corp. with Reserved Font Name "Plex" | [`assets/fonts/IBM_Plex_Sans_Arabic/OFL.txt`](assets/fonts/IBM_Plex_Sans_Arabic/OFL.txt) |

The OFL text is also available at <https://openfontlicense.org/>.

## Dart and Flutter packages

Direct dependencies are declared in [`pubspec.yaml`](pubspec.yaml). Each package keeps its own licence in the pub cache and publishes it on pub.dev; the table below is a human-readable summary, not a replacement for those files.

| Package | Used for | Licence |
| --- | --- | --- |
| `flutter` / `flutter_test` / `flutter_localizations` | Framework and test harness | BSD-3-Clause |
| `equatable` | Value equality for entities and states | MIT |
| `flutter_bloc` | Cubit state management | MIT |
| `fpdart` | `Either` result type | MIT |
| `get_it` | Dependency injection | MIT |
| `go_router` | Declarative navigation | BSD-3-Clause |
| `intl` | Date, number and plural formatting | BSD-3-Clause |
| `shared_preferences` | Persisted theme and language | BSD-3-Clause |
| `bloc_test` | Cubit state-sequence tests | MIT |
| `dependency_validator` | Fails CI on unused or missing dependencies | MIT |
| `mocktail` | Test doubles | MIT |
| `very_good_analysis` | Lint rules | MIT |

Transitive dependencies are pinned in [`pubspec.lock`](pubspec.lock). `dart pub deps --style=compact` prints the full graph, and `flutter pub deps --json` is available for tooling.

## Assets and services not yet in the build

When these land, they must be added here before release:

- **OpenStreetMap tiles** — © OpenStreetMap contributors, ODbL. Attribution must be visible on the map screen (Week 5).
- **Material Symbols / Material Icons** — Apache License 2.0, via the Flutter framework.
- **Any route or achievement artwork** — must be original or licensed, with the source recorded in this file.

## Updating this file

Adding a dependency or an asset means three things in the same pull request:

1. Add the row above with its licence and a link to the licence text.
2. Confirm the licence is compatible with a closed-source store build.
3. Copy the licence into the repo when the licence requires distribution with the binary.

If a licence cannot be confirmed, the dependency does not ship.
