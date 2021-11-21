import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showSuccess(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.green,
        ),
      );

  static void showError(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

  static void showInfo(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            message,
            style: TextStyle(color: AppColors.black),
          ),
          backgroundColor: AppColors.accentL,
        ),
      );
}
