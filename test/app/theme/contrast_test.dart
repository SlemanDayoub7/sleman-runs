import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';

/// WCAG 2.1 relative contrast ratio.
double contrastRatio(Color foreground, Color background) {
  final a = foreground.computeLuminance();
  final b = background.computeLuminance();
  final lighter = a > b ? a : b;
  final darker = a > b ? b : a;
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('light theme', () {
    const colors = AppColors.light;

    test('primary text is readable on both surfaces', () {
      expect(
        contrastRatio(colors.textPrimary, colors.background),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.textPrimary, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('secondary text is readable on both surfaces', () {
      expect(
        contrastRatio(colors.textSecondary, colors.background),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.textSecondary, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('text on primary is readable', () {
      expect(
        contrastRatio(colors.onPrimary, colors.primary),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('status colours are readable on cards', () {
      expect(
        contrastRatio(colors.success, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.warning, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.error, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('primary is visible as a UI boundary on the background', () {
      expect(
        contrastRatio(colors.primary, colors.background),
        greaterThanOrEqualTo(3),
      );
      expect(
        contrastRatio(colors.outline, colors.surface),
        greaterThanOrEqualTo(1.2),
      );
    });
  });

  group('dark theme', () {
    const colors = AppColors.dark;

    test('primary text is readable on both surfaces', () {
      expect(
        contrastRatio(colors.textPrimary, colors.background),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.textPrimary, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('secondary text is readable on both surfaces', () {
      expect(
        contrastRatio(colors.textSecondary, colors.background),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.textSecondary, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('text on primary is readable', () {
      expect(
        contrastRatio(colors.onPrimary, colors.primary),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('status colours are readable on cards', () {
      expect(
        contrastRatio(colors.success, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.warning, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(colors.error, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('GPS lock is readable on the background', () {
      expect(
        contrastRatio(colors.gpsLocked, colors.background),
        greaterThanOrEqualTo(4.5),
      );
    });
  });

  test('every text token differs between themes', () {
    expect(AppColors.light.textPrimary, isNot(AppColors.dark.textPrimary));
    expect(AppColors.light.background, isNot(AppColors.dark.background));
    expect(AppColors.light.primary, isNot(AppColors.dark.primary));
  });
}
