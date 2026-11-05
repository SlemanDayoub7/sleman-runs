import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/app_text_styles.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';

/// The roles defined by the Design type scale.
enum AppTextRole { metric, h1, h2, h3, body, label, caption }

/// The only text widget the app should use.
///
/// It couples a role (size and weight) with a semantic tone, so a screen cannot
/// invent a new text style. `metric` forces left-to-right and tabular figures,
/// which keeps `5:42 /km` readable in Arabic.
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    this.role = AppTextRole.body,
    this.tone,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.semanticsLabel,
    super.key,
  });

  /// Live distance, timer or pace. Always LTR, always tabular.
  const AppText.metric(
    this.data, {
    this.tone = AppTone.primary,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : role = AppTextRole.metric,
       softWrap = true;

  final String data;
  final AppTextRole role;
  final AppTone? tone;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final base = switch (role) {
      AppTextRole.metric => context.textTheme.metric,
      AppTextRole.h1 => context.textTheme.h1,
      AppTextRole.h2 => context.textTheme.h2,
      AppTextRole.h3 => context.textTheme.h3,
      AppTextRole.body => context.textTheme.body,
      AppTextRole.label => context.textTheme.label,
      AppTextRole.caption => context.textTheme.caption,
    };
    final tone = this.tone;
    final style = tone == null
        ? base
        : base.copyWith(color: tone.color(context.appColors));

    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
      textDirection: role == AppTextRole.metric ? TextDirection.ltr : null,
    );
  }
}
