import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';

class CustomRadioWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double width;
  final double height;

  CustomRadioWidget({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.width = 20,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(this.value);
      },
      child: Container(
        height: this.height,
        width: this.width,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: AppColors.gray,
        ),
        child: Center(
          child: Container(
            height: this.height - 4,
            width: this.width - 4,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(),
              color: AppColors.white,
            ),
            child: Center(
              child: value == groupValue
                  ? Icon(
                      Icons.done,
                      color: AppColors.accentL,
                      size: 16,
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }
}
