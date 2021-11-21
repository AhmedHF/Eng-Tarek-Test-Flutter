import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:value_client/core/config/constants.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';

class ImagePickerDialogBox extends StatefulWidget {
  final Function onPickImage;

  const ImagePickerDialogBox({
    Key? key,
    required this.onPickImage,
  }) : super(key: key);

  @override
  _ImagePickerDialogBoxState createState() => _ImagePickerDialogBoxState();
}

class _ImagePickerDialogBoxState extends State<ImagePickerDialogBox> {
  File? image;

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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  AppLocalizations.of(context)!.choose_photo_from,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryDark,
                  ),
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
                      pickImage(ImageSource.camera);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.camera,
                      style: const TextStyle(color: AppColors.accentL),
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
                      pickImage(ImageSource.gallery);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.gallary,
                      style: const TextStyle(color: AppColors.accentL),
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

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imageTemp = File(image.path);
      debugPrint('imageTemp=>>>$imageTemp');
      widget.onPickImage(imageTemp);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}
