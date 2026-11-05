import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';
import 'package:sleman_runs/shared/widgets/app_scaffold.dart';

import '../../support/pump_themed.dart';

void main() {
  const bodyKey = Key('body');

  Future<Rect> pumpScaffold(
    WidgetTester tester, {
    required Size size,
    bool fullBleed = false,
  }) async {
    await pumpThemed(
      tester,
      AppScaffold(
        fullBleed: fullBleed,
        body: const SizedBox.expand(key: bodyKey),
      ),
      size: size,
    );
    return tester.getRect(find.byKey(bodyKey));
  }

  testWidgets('uses the compact gutter on phones', (tester) async {
    final rect = await pumpScaffold(
      tester,
      size: const Size(412, 915),
    );

    expect(rect.left, AppSpacing.gutter);
    expect(rect.right, 412 - AppSpacing.gutter);
  });

  testWidgets('uses the wide gutter on small tablets', (tester) async {
    final rect = await pumpScaffold(
      tester,
      size: const Size(800, 915),
    );

    // Content is capped at 600 dp and centred, then padded by the wide gutter.
    expect(
      rect.left,
      (800 - AppSizes.maxContentWidth) / 2 + AppSpacing.gutterWide,
    );
    expect(
      rect.right,
      800 - (800 - AppSizes.maxContentWidth) / 2 - AppSpacing.gutterWide,
    );
  });

  testWidgets('caps content at the maximum width and centres it', (
    tester,
  ) async {
    final rect = await pumpScaffold(
      tester,
      size: const Size(1000, 915),
    );

    expect(rect.width, AppSizes.maxContentWidth - AppSpacing.gutterWide * 2);
    expect(rect.center.dx, 500);
  });

  testWidgets('full bleed ignores the gutter but fills the screen', (
    tester,
  ) async {
    final rect = await pumpScaffold(
      tester,
      size: const Size(412, 915),
      fullBleed: true,
    );

    expect(rect.left, 0);
    expect(rect.width, 412);
  });
}
