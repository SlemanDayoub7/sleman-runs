import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';

/// Page shell that owns safe area, the responsive gutter and the content cap.
///
/// Phones get a 20 px gutter; tablets get 24 and content stops growing at
/// [AppSizes.maxContentWidth]. Set [fullBleed] for the live map, which should
/// ignore padding but still respect the status bar.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.fullBleed = false,
    this.padding,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool fullBleed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final horizontalGutter = context.window.isCompact
        ? AppSpacing.gutter
        : AppSpacing.gutterWide;
    final resolvedPadding =
        padding ??
        EdgeInsetsDirectional.symmetric(horizontal: horizontalGutter);

    final content = fullBleed
        ? body
        : Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.maxContentWidth,
              ),
              child: Padding(padding: resolvedPadding, child: body),
            ),
          );

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(top: appBar == null, child: content),
    );
  }
}
