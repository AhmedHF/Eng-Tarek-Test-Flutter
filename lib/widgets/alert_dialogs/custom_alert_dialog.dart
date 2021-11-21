import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:value_client/core/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final Function onPressedYes;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.onPressedYes,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
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
              const SizedBox(
                height: 20,
              ),
              // IconButton(
              //   onPressed: () => Navigator.of(context).pop(),
              //   icon: Icon(AppIcons.close),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, color: AppColors.primaryDark),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Center(
                  child: Container(
                    height: 1.0,
                    color: AppColors.gray,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onPressedYes();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.yes,
                      style: TextStyle(color: AppColors.accentL),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Container(
                        width: 1.0,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.no,
                      style: TextStyle(color: AppColors.accentL),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
