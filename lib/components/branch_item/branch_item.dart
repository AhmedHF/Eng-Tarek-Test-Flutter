import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/models/branch.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:expandable/expandable.dart';

class BranchItem extends StatelessWidget {
  final BranchModel item;
  const BranchItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DottedBorder(
        color: AppColors.grayText,
        strokeWidth: 1,
        dashPattern: const [4],
        padding: const EdgeInsets.only(bottom: 20),
        customPath: (size) {
          return Path()
            ..moveTo(0, size.height)
            ..lineTo(size.width, size.height);
        },
        child: ExpandablePanel(
          header: Text(
            item.name,
            softWrap: true,
            style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          collapsed: Container(),
          expanded: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.access_time, color: AppColors.primaryDark),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.work_time,
                    style: const TextStyle(color: AppColors.primaryDark),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    ' ${AppLocalizations.of(context)!.from} ${item.from} P.M',
                    style: const TextStyle(
                        color: AppColors.primaryL, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    ' ${AppLocalizations.of(context)!.to} ${item.to} P.M',
                    style: const TextStyle(
                        color: AppColors.primaryL, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
