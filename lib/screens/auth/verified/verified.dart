import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/index.dart';

class VerifiedScreen extends StatefulWidget {
  const VerifiedScreen({Key? key}) : super(key: key);

  @override
  _VerifiedScreenState createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: NetworkSensitive(
        child: Stack(
          children: <Widget>[
            Image.asset(
              AppImages.background,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.verified,
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppLocalizations.of(context)!.account_created,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    AppLocalizations.of(context)!
                        .your_account_created_succesfully,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.continue_to_start_using_app,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    width: 300,
                    title: AppLocalizations.of(context)!.continue_btn,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.appHome, (route) => false);
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
