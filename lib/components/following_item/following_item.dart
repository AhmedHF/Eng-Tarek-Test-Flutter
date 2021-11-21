import 'package:flutter/material.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/app_button.dart';

class FollowingsItem extends StatelessWidget {
  final FollowingsModel item;
  const FollowingsItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.white,
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Icon(
                    Icons.person,
                    color: AppColors.gray,
                  ),
                  Text(
                    item.count,
                    style: const TextStyle(color: AppColors.gray, fontSize: 20),
                  ),
                  const Text(
                    'K',
                    style: TextStyle(color: AppColors.gray, fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: AppButton(
                title: AppLocalizations.of(context)!.un_follow,
                onPressed: () {},
                backgroundColor: AppColors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
