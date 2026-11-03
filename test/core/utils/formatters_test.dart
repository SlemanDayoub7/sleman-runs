import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/core/utils/formatters.dart';
import 'package:sleman_runs/core/utils/units.dart';

void main() {
  group('formatDuration', () {
    test('formats sub-hour durations as m:ss', () {
      expect(formatDuration(Duration.zero), '0:00');
      expect(formatDuration(const Duration(seconds: 65)), '1:05');
      expect(formatDuration(const Duration(minutes: 28, seconds: 30)), '28:30');
    });

    test('formats hour-plus durations as h:mm:ss', () {
      expect(formatDuration(const Duration(seconds: 3725)), '1:02:05');
      expect(formatDuration(const Duration(hours: 2, seconds: 7)), '2:00:07');
    });

    test('truncates sub-second precision', () {
      expect(
        formatDuration(const Duration(milliseconds: 1999)),
        '0:01',
      );
    });
  });

  group('formatDistance', () {
    test('formats kilometres with two decimals', () {
      expect(formatDistance(5000, DistanceUnit.kilometers), '5.00');
      expect(formatDistance(1234, DistanceUnit.kilometers), '1.23');
    });

    test('formats miles with two decimals', () {
      expect(formatDistance(1609.344, DistanceUnit.miles), '1.00');
    });

    test('handles zero', () {
      expect(formatDistance(0, DistanceUnit.kilometers), '0.00');
    });
  });

  group('formatPace', () {
    test('computes minutes per kilometre', () {
      expect(
        formatPace(
          elapsed: const Duration(minutes: 28, seconds: 30),
          meters: 5000,
          unit: DistanceUnit.kilometers,
        ),
        '5:42',
      );
    });

    test('computes minutes per mile', () {
      expect(
        formatPace(
          elapsed: const Duration(minutes: 10),
          meters: 1609.344,
          unit: DistanceUnit.miles,
        ),
        '10:00',
      );
    });

    test('rounds to the nearest second', () {
      // 1711 s over 5 km is 342.2 s/km, which should read as 5:42.
      expect(
        formatPace(
          elapsed: const Duration(seconds: 1711),
          meters: 5000,
          unit: DistanceUnit.kilometers,
        ),
        '5:42',
      );
    });

    test('returns a placeholder when there is not enough data', () {
      expect(
        formatPace(
          elapsed: Duration.zero,
          meters: 0,
          unit: DistanceUnit.kilometers,
        ),
        '--:--',
      );
      expect(
        formatPace(
          elapsed: const Duration(seconds: 30),
          meters: 0,
          unit: DistanceUnit.kilometers,
        ),
        '--:--',
      );
    });
  });

  test('formatPaceWithUnit appends the unit suffix', () {
    expect(
      formatPaceWithUnit(
        elapsed: const Duration(minutes: 28, seconds: 30),
        meters: 5000,
        unit: DistanceUnit.kilometers,
      ),
      '5:42 /km',
    );
  });
}
