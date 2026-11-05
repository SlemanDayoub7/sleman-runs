import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/tokens/app_radii.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';

/// A static placeholder block.
///
/// Deliberately not animated: a looping shimmer during a run costs battery and
/// frames for information the user can already infer.
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    this.width,
    this.height = AppSizes.icon,
    this.radius = AppRadii.input,
    super.key,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.appColors.surfaceVariant,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
