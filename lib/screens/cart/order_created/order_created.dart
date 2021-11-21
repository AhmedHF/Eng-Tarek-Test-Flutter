import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/index.dart';

class OrderCreatedScreen extends StatelessWidget {
  const OrderCreatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bg,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: Container(),
        ),
        body: NetworkSensitive(
          child: Stack(
            children: <Widget>[
              Image.asset(
                AppImages.backgroundwhite,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 50,
                        top: 50,
                        bottom: 50,
                      ),
                      child: Image.asset(
                        AppImages.done,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.congratulations,
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.for_saving_money,
                      style: const TextStyle(
                          color: AppColors.grayText, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      width: 250,
                      title: AppLocalizations.of(context)!.continue_btn,
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.appHome, (route) => false);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
