import 'package:flutter/material.dart';

/// Typed access to the roles defined by the Design type scale.
///
/// A feature should never hand-build a [TextStyle]. It picks a role here and a
/// tone from `AppText`.
extension AppTextStyles on TextTheme {
  TextStyle get metric => displayLarge!;

  TextStyle get h1 => headlineLarge!;

  TextStyle get h2 => headlineMedium!;

  TextStyle get h3 => titleMedium!;

  TextStyle get body => bodyLarge!;

  TextStyle get label => labelLarge!;

  TextStyle get caption => labelSmall!;
}
