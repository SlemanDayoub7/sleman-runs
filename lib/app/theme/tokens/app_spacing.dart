/// The only spacing values the app is allowed to use.
///
/// Tokens are plain constants rather than a theme extension because they do
/// not change with brightness or locale. Putting them in a theme would make
/// Flutter interpolate constants during every theme transition for no gain.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Horizontal page gutter on compact widths.
  static const double gutter = 20;

  /// Horizontal page gutter on tablets and foldables.
  static const double gutterWide = 24;
}
