import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';

/// A Material icon with a semantic tone and a default size.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    this.size = AppSizes.icon,
    this.tone = AppTone.secondary,
    this.semanticLabel,
    super.key,
  });

  final IconData icon;
  final double size;
  final AppTone tone;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: tone.color(context.appColors),
      semanticLabel: semanticLabel,
    );
  }
}
