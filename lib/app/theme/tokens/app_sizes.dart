/// Fixed component sizes that are not spacing or radius.
abstract final class AppSizes {
  /// WCAG 2.5.5 / Material minimum interactive target.
  static const double minTapTarget = 48;

  /// Content is centred past this width so tablets do not stretch a form
  /// across 1 000 logical pixels.
  static const double maxContentWidth = 600;

  static const double icon = 24;
  static const double iconSmall = 16;
  static const double iconLarge = 32;

  /// Diameter of the circular artwork in an empty state.
  static const double emptyArtwork = 72;

  static const double border = 1;
}
