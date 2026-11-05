/// Material 3 width classes, used for the responsive layout rules.
///
/// Height is deliberately absent: phones are locked to portrait, so layout
/// decisions should follow width and available space, not a hard-coded
/// device height.
enum AppWindowClass {
  /// Phones in portrait: `< 600` logical pixels.
  compact,

  /// Small tablets, unfolded foldables: `600–839`.
  medium,

  /// Tablets and desktop-sized windows: `>= 840`.
  expanded
  ;

  static AppWindowClass fromWidth(double width) {
    if (width < 600) {
      return AppWindowClass.compact;
    }
    if (width < 840) {
      return AppWindowClass.medium;
    }
    return AppWindowClass.expanded;
  }

  bool get isCompact => this == AppWindowClass.compact;
}
