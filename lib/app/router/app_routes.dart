/// Every route in one place, so no widget ever hardcodes a path string.
abstract final class AppRoutes {
  static const track = '/track';
  static const history = '/history';
  static const plan = '/plan';
  static const settings = '/settings';

  /// Deep link target for a finished run (used from notifications in Week 5).
  static String runDetail(String id) => '$history/$id';
}
