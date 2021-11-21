import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';

Widget lineBorder() {
  return DottedBorder(
    customPath: (size) {
      return Path()
        ..moveTo(0, 0)
        ..lineTo(size.width, 0);
    },
    color: AppColors.gray,
    dashPattern: [5, 3],
    child: Container(),
  );
}
