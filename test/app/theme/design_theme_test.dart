import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/app_text_styles.dart';
import 'package:sleman_runs/app/theme/app_theme.dart';
import 'package:sleman_runs/app/theme/app_typography.dart';

void main() {
  group('theme cache', () {
    test('returns the same instance for the same variant', () {
      expect(
        identical(AppTheme.lightEn, AppTheme.of(AppThemeVariant.lightEn)),
        isTrue,
      );
      expect(
        identical(AppTheme.darkAr, AppTheme.of(AppThemeVariant.darkAr)),
        isTrue,
      );
    });

    test('builds one distinct theme per brightness and locale', () {
      final themes = {
        AppTheme.lightEn,
        AppTheme.lightAr,
        AppTheme.darkEn,
        AppTheme.darkAr,
      };

      expect(themes, hasLength(4));
      expect(AppTheme.lightEn.brightness, Brightness.light);
      expect(AppTheme.darkAr.brightness, Brightness.dark);
    });
  });

  group('typography', () {
    test('maps roles to the Design size scale', () {
      final textTheme = AppTheme.lightEn.textTheme;

      expect(textTheme.metric.fontSize, 56);
      expect(textTheme.h1.fontSize, 32);
      expect(textTheme.h2.fontSize, 24);
      expect(textTheme.h3.fontSize, 19);
      expect(textTheme.body.fontSize, 16);
      expect(textTheme.label.fontSize, 14);
      expect(textTheme.caption.fontSize, 12);
    });

    test('uses the bundled family for each locale', () {
      expect(AppTheme.lightEn.textTheme.body.fontFamily, AppFonts.latin);
      expect(AppTheme.lightAr.textTheme.body.fontFamily, AppFonts.arabic);
      expect(AppTheme.lightEn.textTheme.metric.fontFamily, AppFonts.mono);
      expect(AppTheme.lightAr.textTheme.metric.fontFamily, AppFonts.mono);
    });

    test('sets variable-font weight through the wght axis', () {
      final metric = AppTheme.lightEn.textTheme.metric;
      final variation = metric.fontVariations!.single;

      expect(variation.axis, 'wght');
      expect(variation.value, 700);
    });

    test('adds 10 percent line height for Arabic', () {
      final english = AppTheme.lightEn.textTheme.body.height!;
      final arabic = AppTheme.lightAr.textTheme.body.height!;

      expect(arabic, closeTo(english * 1.1, 0.001));
    });

    test('does not add the Arabic line height to the mono metric', () {
      expect(
        AppTheme.lightAr.textTheme.metric.height,
        AppTheme.lightEn.textTheme.metric.height,
      );
    });
  });

  group('component themes', () {
    test('uses token colours for the app bar and background', () {
      final theme = AppTheme.lightEn;
      final colors = theme.extension<AppColors>();

      expect(theme.appBarTheme.backgroundColor, colors!.background);
      expect(theme.scaffoldBackgroundColor, colors.background);
    });

    test('guarantees a 48 dp minimum button target', () {
      final size = AppTheme.lightEn.filledButtonTheme.style!.minimumSize!;

      expect(size.resolve(<WidgetState>{}), const Size(64, 48));
    });

    test('keeps cards flat and bordered', () {
      final card = AppTheme.lightEn.cardTheme;

      expect(card.elevation, 0);
      expect(card.surfaceTintColor, Colors.transparent);
      expect(card.shape, isA<RoundedRectangleBorder>());
    });
  });
}
