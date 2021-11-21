import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppConditionalBuilder extends StatelessWidget {
  /// Condition to control what gets rendered.
  /// in loading, success and error.
  final bool successCondition;
  final bool loadingCondition;
  final bool errorCondition;
  final bool emptyCondition;

  /// pass to AppError if [errorCondition] is true and [errorBuilder] = null.
  final String errorMessage;

  final Color? loadingColor;

  /// Run if [successCondition] is true.
  final WidgetBuilder successBuilder;

  /// Run if [errorCondition] is true.
  final WidgetBuilder? errorBuilder;

  /// Run if [emptyCondition] is true.
  final WidgetBuilder? emptyBuilder;

  const AppConditionalBuilder({
    Key? key,
    required this.loadingCondition,
    required this.emptyCondition,
    required this.errorCondition,
    required this.errorMessage,
    required this.successCondition,
    required this.successBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (successCondition && !emptyCondition)
      return successBuilder(context);
    else if (loadingCondition)
      return AppLoading(
          color: loadingColor != null ? loadingColor! : AppColors.primaryL);
    else if (errorCondition) {
      if (errorBuilder != null)
        return errorBuilder!(context);
      else
        return AppError(error: errorMessage);
    } else if (emptyCondition) {
      if (emptyBuilder != null)
        return emptyBuilder!(context);
      else
        return _emptyBuilder(context);
    } else
      return Container();
  }

  Widget _emptyBuilder(context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.no_data),
    );
  }
}
