import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/app_theme.dart';
import 'package:sleman_runs/core/error/failure.dart';
import 'package:sleman_runs/shared/widgets/app_error_view.dart';

import '../../support/pump_themed.dart';

void main() {
  testWidgets('maps every failure code to one localised sentence', (
    tester,
  ) async {
    const cases = <(Failure, String)>[
      (
        PermissionFailure(),
        'Location permission is required to record a run.',
      ),
      (
        LocationUnavailableFailure(),
        'GPS signal is unavailable. Move to open sky and try again.',
      ),
      (StorageFailure(), 'Your settings could not be saved.'),
      (ValidationFailure(), "That value doesn't look right."),
      (UnknownFailure(), 'Something went wrong.'),
    ];

    for (final (failure, message) in cases) {
      await pumpThemed(
        tester,
        AppErrorView(failure: failure, onRetry: () {}),
      );

      expect(find.text(message), findsOneWidget, reason: failure.code.name);
    }
  });

  testWidgets('shows the localised title and retry label', (tester) async {
    await pumpThemed(
      tester,
      AppErrorView(failure: const UnknownFailure(), onRetry: () {}),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('retries once per tap', (tester) async {
    var retries = 0;
    await pumpThemed(
      tester,
      AppErrorView(
        failure: const StorageFailure(),
        onRetry: () => retries++,
      ),
    );

    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(retries, 1);
  });

  testWidgets('accepts a screen-specific title', (tester) async {
    await pumpThemed(
      tester,
      AppErrorView(
        title: 'Could not load your runs',
        failure: const StorageFailure(),
        onRetry: () {},
      ),
    );

    expect(find.text('Could not load your runs'), findsOneWidget);
  });

  testWidgets('translates the failure in Arabic', (tester) async {
    await pumpThemed(
      tester,
      AppErrorView(failure: const PermissionFailure(), onRetry: () {}),
      variant: AppThemeVariant.lightAr,
    );

    expect(
      find.text('يجب السماح بالوصول إلى الموقع لتسجيل جريك.'),
      findsOneWidget,
    );
    expect(find.text('إعادة المحاولة'), findsOneWidget);
  });
}
