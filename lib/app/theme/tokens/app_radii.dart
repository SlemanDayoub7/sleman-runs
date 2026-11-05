import 'package:flutter/widgets.dart';

/// Corner radii for every surface in the app.
abstract final class AppRadii {
  static const double input = 8;
  static const double card = 16;
  static const double sheet = 24;
  static const double pill = 999;

  static const BorderRadius inputAll = BorderRadius.all(
    Radius.circular(input),
  );
  static const BorderRadius cardAll = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius sheetAll = BorderRadius.all(
    Radius.circular(sheet),
  );
  static const BorderRadius sheetTop = BorderRadius.vertical(
    top: Radius.circular(sheet),
  );
  static const BorderRadius pillAll = BorderRadius.all(
    Radius.circular(pill),
  );
}
