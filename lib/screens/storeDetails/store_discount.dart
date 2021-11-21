import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/index.dart';

class StoreDiscount extends StatefulWidget {
  final Map<String, dynamic> storeDetails;
  StoreDiscount(this.storeDetails);

  @override
  _StoreDiscountState createState() => _StoreDiscountState();
}

class _StoreDiscountState extends State<StoreDiscount> {
  Widget _buildDicountCard(int value, String label) {
    return (Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 60,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.accentL,
              gradient: LinearGradient(
                colors: [AppColors.accentL.withOpacity(.6), AppColors.accentL],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              '$value %',
              style: TextStyle(color: AppColors.white, fontSize: 20),
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.primaryDark, fontSize: 16),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: ShapeDecoration(
        shape: WeirdBorder(radius: 10, pathWidth: 1000),
        color: AppColors.white,
      ),
      child: DottedBorder(
        color: AppColors.gray,
        strokeWidth: 2,
        // radius: Radius.circular(5),
        dashPattern: [5],
        customPath: (size) {
          return Path()
            ..moveTo(0, size.height)
            ..lineTo(size.width, size.height);
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppLocalizations.of(context)!.discount,
            style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          ...widget.storeDetails['discount']['memberships']
              .map((item) => _buildDicountCard(
                  item['discount'], item['membership']['name']))
              .toList()
        ]),
      ),
    );
  }
}
