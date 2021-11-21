import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/countdown_timer.dart';
import 'package:value_client/widgets/index.dart';

class StoreUpdate extends StatefulWidget {
  final Map<String, dynamic> storeDetails;
  StoreUpdate(this.storeDetails);

  @override
  _StoreUpdateState createState() => _StoreUpdateState();
}

class _StoreUpdateState extends State<StoreUpdate> {
  @override
  Widget build(BuildContext context) {
    // TODO change to_data to last_update of store from api
    final from = DateTime.parse(widget.storeDetails['last_update']);
    final to = DateTime.now();
    final difference = to.difference(from).inSeconds;
    return Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
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
              ..moveTo(5, size.height)
              ..lineTo(size.width - 5, size.height);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.new_update,
                    style: TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  CountDownTimer(difference, 55, false)
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
