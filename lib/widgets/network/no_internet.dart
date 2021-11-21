import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInterNetConnection extends StatelessWidget {
  const NoInterNetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(height: 30),
          Image.asset(
            AppImages.no_result,
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!.sorry_no_internet,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 50),
          // AppButton(
          //   width: 280,
          //   title: AppLocalizations.of(context)!.back,
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pop();
          //   },
          // ),
        ],
      ),
    );
  }
}
