import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/shared/widgets/app_button.dart';

import '../../support/pump_themed.dart';

void main() {
  testWidgets('runs the callback when tapped', (tester) async {
    var taps = 0;
    await pumpThemed(
      tester,
      AppButton(label: 'Save', onPressed: () => taps++),
    );

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(taps, 1);
  });

  testWidgets('is disabled when onPressed is null', (tester) async {
    await pumpThemed(tester, const AppButton(label: 'Save'));

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('shows a spinner and blocks taps while loading', (tester) async {
    var taps = 0;
    await pumpThemed(
      tester,
      AppButton(
        label: 'Save',
        isLoading: true,
        onPressed: () => taps++,
      ),
      settle: false,
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Save'), findsNothing);

    await tester.tap(find.byType(FilledButton), warnIfMissed: false);
    await tester.pump();

    expect(taps, 0);
  });

  testWidgets('expands to the available width when requested', (tester) async {
    await pumpThemed(
      tester,
      AppButton(label: 'Start run', expand: true, onPressed: () {}),
    );

    expect(tester.getSize(find.byType(FilledButton)).width, 412);
  });

  testWidgets('renders an icon next to the label', (tester) async {
    await pumpThemed(
      tester,
      AppButton(label: 'Start run', icon: Icons.play_arrow, onPressed: () {}),
    );

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(
      tester.getSize(find.byIcon(Icons.play_arrow)).width,
      AppSizes.iconSmall,
    );
  });

  testWidgets('maps each variant to its Material button', (tester) async {
    await pumpThemed(
      tester,
      Column(
        children: [
          AppButton(
            label: 'filled',
            onPressed: () {},
          ),
          AppButton(
            label: 'outlined',
            variant: AppButtonVariant.outlined,
            onPressed: () {},
          ),
          AppButton(
            label: 'text',
            variant: AppButtonVariant.text,
            onPressed: () {},
          ),
        ],
      ),
    );

    expect(find.byType(FilledButton), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}
