import 'package:flutter/material.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/index.dart';

Widget buildCheckbox(CheckBoxModal item) {
    return CheckboxListTile(
      title: Row(children: [
        Text(
          item.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '(${item.count})',
          style: TextStyle(
            color: AppColors.gray,
          ),
        )
      ]),
      value: item.value,
      tileColor: AppColors.red,
      activeColor: AppColors.gray.withOpacity(.2),
      checkColor: AppColors.accentL,
      onChanged: (bool? _value) {
        print(_value);
        // setState(() {
        //   item.value = _value!;
        // });
      },
    );
  }
