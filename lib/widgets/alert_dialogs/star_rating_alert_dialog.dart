import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:value_client/core/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';


class StarRatingAlertDialog extends StatefulWidget {
  const StarRatingAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  _StarRatingAlertDialogState createState() => _StarRatingAlertDialogState();
}

class _StarRatingAlertDialogState extends State<StarRatingAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 30,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(color: Colors.black,offset: Offset(0,5),
            //   blurRadius: 10
            //   ),
            // ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      AppIcons.close,
                      color: AppColors.primaryL,
                      size: 15,
                    ),
                  ),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.rate_store,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: AppColors.gray,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: AppColors.accentL,
                    backgroundColor: AppColors.accentL,
                    side: BorderSide(color: AppColors.accentL, width: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.later,
                    style: TextStyle(
                      color: AppColors.gray,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: AppColors.gray,
                    side: BorderSide(color: AppColors.gray, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
