import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/app_text_styles.dart';
import 'package:sleman_runs/app/theme/app_theme.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

import '../../support/pump_themed.dart';

void main() {
  testWidgets('every role maps to its Design size', (tester) async {
    const samples = <AppTextRole, String>{
      AppTextRole.metric: '5:42',
      AppTextRole.h1: 'h1',
      AppTextRole.h2: 'h2',
      AppTextRole.h3: 'h3',
      AppTextRole.body: 'body',
      AppTextRole.label: 'label',
      AppTextRole.caption: 'caption',
    };

    await pumpThemed(
      tester,
      SingleChildScrollView(
        child: Column(
          children: [
            for (final entry in samples.entries)
              AppText(entry.value, role: entry.key),
          ],
        ),
      ),
    );

    final theme = AppTheme.lightEn.textTheme;
    final expected = <AppTextRole, double>{
      AppTextRole.metric: theme.metric.fontSize!,
      AppTextRole.h1: theme.h1.fontSize!,
      AppTextRole.h2: theme.h2.fontSize!,
      AppTextRole.h3: theme.h3.fontSize!,
      AppTextRole.body: theme.body.fontSize!,
      AppTextRole.label: theme.label.fontSize!,
      AppTextRole.caption: theme.caption.fontSize!,
    };

    for (final entry in samples.entries) {
      final text = tester.widget<Text>(find.text(entry.value));
      expect(
        text.style?.fontSize,
        expected[entry.key],
        reason: 'role ${entry.key.name}',
      );
    }
  });

  testWidgets('uses the semantic tone colour, never a raw hex', (tester) async {
    await pumpThemed(
      tester,
      const AppText('Could not save', tone: AppTone.error),
    );

    final text = tester.widget<Text>(find.text('Could not save'));
    expect(text.style?.color, AppColors.light.error);
  });

  testWidgets('swaps the tone colour with the theme', (tester) async {
    await pumpThemed(
      tester,
      const AppText('Could not save', tone: AppTone.error),
      variant: AppThemeVariant.darkEn,
    );

    final text = tester.widget<Text>(find.text('Could not save'));
    expect(text.style?.color, AppColors.dark.error);
  });

  testWidgets('metric stays left-to-right inside an Arabic layout', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Column(
        children: [
          AppText('5:42 /km'),
          AppText.metric('5:42 /km'),
        ],
      ),
      variant: AppThemeVariant.lightAr,
    );

    final texts = tester
        .widgetList<Text>(find.text('5:42 /km'))
        .toList(growable: false);
    final body = texts.firstWhere((t) => t.textDirection == null);
    final metric = texts.firstWhere(
      (t) => t.textDirection == TextDirection.ltr,
    );

    expect(body.data, '5:42 /km');
    expect(
      Directionality.of(tester.element(find.byType(Column))),
      TextDirection.rtl,
    );
    expect(metric.textDirection, TextDirection.ltr);
  });

  testWidgets('metric always uses the mono, tabular style', (tester) async {
    await pumpThemed(tester, const AppText.metric('12.4'));

    final text = tester.widget<Text>(find.text('12.4'));
    expect(
      text.style?.fontFamily,
      AppTheme.lightEn.textTheme.metric.fontFamily,
    );
    expect(
      text.style?.fontFeatures,
      contains(const FontFeature.tabularFigures()),
    );
    expect(text.style?.color, AppColors.light.primary);
  });

  testWidgets('forwards semantics, max lines and overflow', (tester) async {
    await pumpThemed(
      tester,
      const SizedBox(
        width: 80,
        child: AppText(
          'A very long run description that must be clipped',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          semanticsLabel: 'Long description',
        ),
      ),
    );

    final text = tester.widget<Text>(
      find.text('A very long run description that must be clipped'),
    );
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(text.semanticsLabel, 'Long description');
  });
}
