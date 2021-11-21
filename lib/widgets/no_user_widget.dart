import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';

class NoUserWidget extends StatelessWidget {
  final bool isAlertDialog;
  const NoUserWidget({
    Key? key,
    this.isAlertDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isAlertDialog ? Colors.transparent : AppColors.white,
      width: double.infinity,
      height: !isAlertDialog ? double.infinity : 300,
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isAlertDialog)
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      AppIcons.close,
                      color: AppColors.primaryL,
                      size: 15,
                    ),
                  ),
                ],
              ),
            Text(
              AppLocalizations.of(context)!.start_save_now,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                text: AppLocalizations.of(context)!.you_logged_as,
                style: const TextStyle(
                  fontSize: 16,
                ), // default text style
                children: <TextSpan>[
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.guest,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  if (isAlertDialog) Navigator.of(context).pop();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.loginScreen, (route) => false);
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(
                    color: AppColors.white,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: AppColors.accentL,
                  backgroundColor: AppColors.accentL,
                  side: BorderSide(color: AppColors.accentL, width: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 200,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  if (isAlertDialog) Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(AppRoutes.signupScreen);
                },
                child: Text(
                  AppLocalizations.of(context)!.create_account,
                  style: const TextStyle(
                    color: AppColors.accentL,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: AppColors.accentL,
                  side: const BorderSide(color: AppColors.accentL, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
