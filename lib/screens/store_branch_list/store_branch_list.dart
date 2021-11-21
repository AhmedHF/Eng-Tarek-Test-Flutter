import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/components/branch_item/branch_item.dart';
import 'package:value_client/models/branch.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BranchModel> branches = [
      BranchModel(
        id: 1,
        from: "1:00",
        to: "8:00",
        name: "branch 1",
      ),
      BranchModel(
        id: 2,
        from: "2:00",
        to: "9:00",
        name: "branch 2",
      ),
      BranchModel(
        id: 3,
        from: "1:00",
        to: "20:00",
        name: "branch 3",
      ),
      BranchModel(
        id: 4,
        from: "6:00",
        to: "12:00",
        name: "branch 4",
      ),
      BranchModel(
        id: 5,
        from: "1:00",
        to: "8:00",
        name: "branch 5",
      ),
      BranchModel(
        id: 6,
        from: "2:00",
        to: "10:00",
        name: "branch 6",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      body: NetworkSensitive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DottedBorder(
              color: AppColors.primaryDark,
              strokeWidth: 1,
              dashPattern: [5],
              customPath: (size) {
                return Path()
                  ..moveTo(0, size.height)
                  ..lineTo(size.width, size.height);
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                color: AppColors.backgroundGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.branch_list,
                      style: TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () => {Navigator.of(context).pop()},
                        icon: Icon(
                          AppIcons.close,
                          size: 18,
                          color: AppColors.primaryL,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColors.backgroundGray,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: AppLocalizations.of(context)!.search,
                    hintStyle:
                        TextStyle(color: AppColors.grayText, fontSize: 15),
                    prefixIcon: Icon(
                      AppIcons.search,
                      color: AppColors.grayText,
                      size: 16,
                    ),
                    fillColor: AppColors.backgroundGray,
                    labelStyle: TextStyle(
                      color: AppColors.grayText,
                      backgroundColor: AppColors.grayText,
                    ),
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.grayText),
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    hoverColor: AppColors.backgroundGray),
              ),
            ),
            Expanded(
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                color: AppColors.backgroundGray,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      BranchItem(item: branches[index]),
                  separatorBuilder: separatorBuilder,
                  itemCount: branches.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
