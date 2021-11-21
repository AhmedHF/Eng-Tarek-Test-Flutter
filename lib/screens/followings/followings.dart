import 'package:flutter/material.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

class FollowingsScreen extends StatelessWidget {
  const FollowingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FollowingsModel> followings = [
      FollowingsModel(
        id: '1',
        count: '19',
        image: AppImages.store_1,
      ),
      FollowingsModel(
        id: '2',
        count: '55',
        image: AppImages.store_2,
      ),
      FollowingsModel(
        id: '3',
        count: '14',
        image: AppImages.store_3,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.followings,
        ),
      ),
      // backgroundColor: AppColors.backgroundLightGray,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: NetworkSensitive(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  AppImages.backgroundwhite,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      FollowingsItem(item: followings[index]),
                  separatorBuilder: separatorBuilder,
                  itemCount: followings.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
