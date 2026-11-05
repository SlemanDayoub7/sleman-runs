import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/app_text_styles.dart';
import 'package:sleman_runs/app/theme/app_theme.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/shared/widgets/app_badge.dart';
import 'package:sleman_runs/shared/widgets/app_empty_state.dart';
import 'package:sleman_runs/shared/widgets/app_metric.dart';
import 'package:sleman_runs/shared/widgets/app_section_header.dart';
import 'package:sleman_runs/shared/widgets/app_skeleton.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

import '../../support/pump_themed.dart';

void main() {
  group('AppBadge', () {
    testWidgets('carries meaning in text, not colour alone', (tester) async {
      await pumpThemed(
        tester,
        const AppBadge(label: 'PR', icon: Icons.emoji_events_outlined),
      );

      expect(find.text('PR'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events_outlined), findsOneWidget);
      expect(find.byType(AppText), findsOneWidget);
    });

    testWidgets('paints its pill from the semantic tone', (tester) async {
      await pumpThemed(tester, const AppBadge(label: 'Offline'));

      final box = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(AppBadge),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = box.decoration as BoxDecoration;
      expect(
        decoration.color,
        AppColors.light.primary.withValues(alpha: 0.12),
      );
    });
  });

  group('AppSkeleton', () {
    testWidgets('is excluded from semantics and uses the surface token', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        const Center(child: AppSkeleton(width: 120, height: 16)),
      );

      expect(
        find.descendant(
          of: find.byType(AppSkeleton),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(AppSkeleton),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, AppColors.light.surfaceVariant);
      expect(tester.getSize(find.byType(Container)).height, 16);
    });
  });

  group('AppMetric', () {
    testWidgets('stays left-to-right in Arabic', (tester) async {
      await pumpThemed(
        tester,
        const AppMetric(value: '12.40', unit: 'km', label: 'Distance'),
        variant: AppThemeVariant.lightAr,
      );

      expect(find.text('Distance'), findsOneWidget);
      expect(find.text('12.40'), findsOneWidget);
      expect(find.byType(RepaintBoundary), findsWidgets);

      final row = tester.widget<Directionality>(
        find
            .descendant(
              of: find.byType(AppMetric),
              matching: find.byType(Directionality),
            )
            .last,
      );
      expect(row.textDirection, TextDirection.ltr);
    });

    testWidgets('exposes one spoken label', (tester) async {
      await pumpThemed(
        tester,
        const AppMetric(value: '5:42', unit: '/km', label: 'Pace'),
      );

      final semantics = tester.widget<Semantics>(
        find
            .descendant(
              of: find.byType(AppMetric),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semantics.properties.label, 'Pace 5:42 /km');
    });

    testWidgets('uses the tone of the active theme', (tester) async {
      await pumpThemed(
        tester,
        const AppMetric(value: '1.20', unit: 'km'),
        variant: AppThemeVariant.darkEn,
      );

      final value = tester.widget<Text>(find.text('1.20'));
      expect(value.style?.color, AppColors.dark.textPrimary);
      expect(
        value.style?.fontFamily,
        AppTheme.darkEn.textTheme.metric.fontFamily,
      );
    });
  });

  group('AppSectionHeader', () {
    testWidgets('renders a title and an optional action', (tester) async {
      await pumpThemed(
        tester,
        AppSectionHeader(
          title: 'Recent runs',
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ),
      );

      expect(find.text('Recent runs'), findsOneWidget);
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });
  });

  group('AppEmptyState', () {
    testWidgets('renders artwork, title, body and action', (tester) async {
      await pumpThemed(
        tester,
        AppEmptyState(
          icon: Icons.route_outlined,
          title: 'No runs yet',
          message: 'Your first 5K starts here.',
          action: FilledButton(onPressed: () {}, child: const Text('Start')),
        ),
      );

      expect(find.byIcon(Icons.route_outlined), findsOneWidget);
      expect(find.text('No runs yet'), findsOneWidget);
      expect(find.text('Your first 5K starts here.'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('survives 200 percent text scaling on a 320 dp phone', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        const AppEmptyState(
          icon: Icons.route_outlined,
          tone: AppTone.success,
          title: 'No runs yet',
          message:
              'Your first 5K starts here. Once you finish a run it will '
              'appear in this list with splits, pace and route.',
        ),
        size: const Size(320, 640),
        textScale: 2,
      );

      expect(tester.takeException(), isNull);
    });
  });
}
