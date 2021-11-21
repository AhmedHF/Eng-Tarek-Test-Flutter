import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/utils/utils.dart';
import 'package:value_client/resources/index.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/screens/rated_offers/cubit/rated_offers_cubit.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';

class SortByScreen extends StatefulWidget {
  const SortByScreen({Key? key}) : super(key: key);

  @override
  _SortByScreenState createState() => _SortByScreenState();
}

class _SortByScreenState extends State<SortByScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                header(context),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.top_rated),
                        trailing: radioIcon(SortType.top),
                      ),
                      ListTile(
                        title: Text(
                            AppLocalizations.of(context)!.discount_low_to_high),
                        trailing: radioIcon(SortType.low),
                      ),
                      ListTile(
                        title: Text(
                            AppLocalizations.of(context)!.discount_high_to_low),
                        trailing: radioIcon(SortType.high),
                      ),
                    ],
                  ),
                ),
                continueButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget header(context) {
    return DottedBorder(
      color: AppColors.primaryDark,
      strokeWidth: 1,
      dashPattern: const [5],
      customPath: (size) {
        return Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.sort_by,
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () => {
                Navigator.of(context).pop(),
              },
              icon: const Icon(
                AppIcons.close,
                size: 16,
                color: AppColors.primaryL,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget radioIcon(value) {
    return BlocBuilder<RatedOffersCubit, RatedOffersState>(
      builder: (context, state) {
        RatedOffersCubit cubit = RatedOffersCubit.get(context);
        debugPrint('cubit ....... ${cubit.sortBy.toString()}');

        return Radio<SortType>(
          value: value,
          groupValue: cubit.sortBy,
          onChanged: (SortType? value) {
            cubit.setSortType(value!);
            setState(() {});
          },
        );
      },
    );
  }

  Widget continueButton() {
    return BlocBuilder<RatedOffersCubit, RatedOffersState>(
      builder: (context, state) {
        RatedOffersCubit cubit = RatedOffersCubit.get(context);
        return Expanded(
          flex: 1,
          child: Center(
            child: AppButton(
              width: 280,
              title: AppLocalizations.of(context)!.continue_btn,
              onPressed: () {
                Navigator.of(context).pop(cubit.sortBy);
              },
            ),
          ),
        );
      },
    );
  }
}
