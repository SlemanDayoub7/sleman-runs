import 'package:flutter/services.dart';

/// Loads the bundled fonts into the test engine.
///
/// Widget tests use Ahem by default, which makes goldens meaningless. Goldens
/// call this once so the rendered type is the type users see.
Future<void> loadAppFonts() async {
  final manrope = FontLoader('Manrope')
    ..addFont(rootBundle.load('assets/fonts/Manrope/Manrope[wght].ttf'));
  await manrope.load();

  final mono = FontLoader('JetBrains Mono')
    ..addFont(
      rootBundle.load('assets/fonts/JetBrains_Mono/JetBrainsMono[wght].ttf'),
    );
  await mono.load();

  final arabic = FontLoader('IBM Plex Sans Arabic');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    arabic.addFont(
      rootBundle.load(
        'assets/fonts/IBM_Plex_Sans_Arabic/IBMPlexSansArabic-$weight.ttf',
      ),
    );
  }
  await arabic.load();
}
