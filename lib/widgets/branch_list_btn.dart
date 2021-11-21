import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/widgets/weird_border.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BranchListBtn extends StatelessWidget {
  final Color bgColor;
  final String screenName;
  final String workingFrom;
  final String workingTo;
  final List branches;
  const BranchListBtn(
    this.bgColor,
    this.screenName,
    this.workingFrom,
    this.workingTo,
    this.branches, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: WeirdBorder(radius: 10, pathWidth: 1000, top: true),
          color: bgColor),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(screenName, arguments: {
            'branches': branches,
            'workingFrom': workingFrom,
            'workingTo': workingTo,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.backgroundGray),
                      borderRadius: BorderRadius.circular(17)),
                  child: const Icon(
                    AppIcons.group_9970,
                    color: AppColors.backgroundGray,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  AppLocalizations.of(context)!.branch_list,
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryDark,
              size: 15,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            right: 15,
          ),
        ),
      ),
    );
  }
}
