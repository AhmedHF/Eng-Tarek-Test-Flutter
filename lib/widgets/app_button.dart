import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/widgets/app_loading.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;
  final Color backgroundColor;
  final Color titleColor;
  final double width;

  const AppButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = AppColors.accentL,
    this.titleColor = AppColors.white,
    this.width = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      // onPrimary: AppColors.accentL,
      primary: backgroundColor,
      minimumSize: Size(width, 45),
      maximumSize: Size(width, 45),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    );

    final TextStyle titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: titleColor,
    );
    return ElevatedButton(
      style: elevatedButtonStyle,
      onPressed: onPressed,
      child: loading
          ? const AppLoading(
              scale: 0.5,
            )
          : Text(
              title,
              style: titleStyle,
            ),
    );
  }
}
