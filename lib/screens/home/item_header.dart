import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemHeader extends StatelessWidget {
  final String title;
  final bool viewAll;
  final VoidCallback? onPress;
  ItemHeader({
    Key? key,
    required this.title,
    this.viewAll = true,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: viewAll
              ? const EdgeInsets.symmetric(horizontal: 10.0)
              : const EdgeInsets.all(10),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        viewAll
            ? TextButton(
                onPressed: onPress,
                child: Text(
                  AppLocalizations.of(context)!.view_all,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            : Container(),
      ],
    );
  }
}
