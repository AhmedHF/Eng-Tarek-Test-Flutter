import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutCard extends StatelessWidget {
  final CartModel item;
  CheckoutCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.gray,
      strokeWidth: 1,
      dashPattern: [5],
      customPath: (size) {
        return Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height);
      },
      child: Container(
        height: 105,
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                item.description,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryL, width: 1.5),
                  ),
                  child: Text(
                    '${item.price.toString()} ${AppLocalizations.of(context)!.sar}',
                    style: TextStyle(fontSize: 18, color: AppColors.primaryL),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.quantity,
                      style: TextStyle(fontSize: 16, color: AppColors.gray),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        AppIcons.add,
                        color: AppColors.white,
                        size: 16,
                      ),
                      color: AppColors.backgroundGray,
                    ),
                    Container(
                      child: Text(
                        item.qty.toString(),
                        style: TextStyle(
                          color: AppColors.backgroundGray,
                          fontSize: 18,
                        ),
                      ),
                      width: 55,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.backgroundGray, width: 1.5),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        AppIcons.minus_sign,
                        color: AppColors.white,
                        size: 16,
                      ),
                      color: AppColors.backgroundGray,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
