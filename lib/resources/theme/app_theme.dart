import 'package:flutter/material.dart';
import '../colors/colors.dart';

extension on ThemeData {
  ThemeData setCommonThemeElements() => this.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: colorScheme.copyWith(secondary: AppColors.accentL),
      );
}

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryL,
      scaffoldBackgroundColor: AppColors.primaryL,
      // cardColor: AppColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryL,
        elevation: 0,
      ),
      fontFamily: 'din-next',

      // radio button
      unselectedWidgetColor: AppColors.gray,
      toggleableActiveColor: AppColors.accentL,

      // textSelectionTheme
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.secondaryL,
        selectionColor: AppColors.secondaryL,
        selectionHandleColor: AppColors.secondaryL,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
        caption: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: AppColors.black),
        subtitle2: TextStyle(color: AppColors.black),
        headline1: TextStyle(
          fontSize: 40,
          color: AppColors.white,
        ),
        headline2: TextStyle(
          fontSize: 20,
          color: AppColors.white,
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: AppColors.white,
        ),
        headline4: TextStyle(
          color: Colors.black,
        ),
        headline5: TextStyle(
          color: Colors.black,
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        contentPadding: EdgeInsets.zero,
        hoverColor: AppColors.secondaryL,
        focusColor: AppColors.secondaryL,
        hintStyle: TextStyle(color: AppColors.black),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryL,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          backgroundColor: AppColors.white,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.white,
          backgroundColor: AppColors.accentL,
          minimumSize: Size(100, 45),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          minimumSize: Size(100, 45),
          // padding: EdgeInsets.symmetric(horizontal: 16),
          side: BorderSide(color: Colors.white, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),

      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     primary: AppColors.accentL,
      //   ),
      // ),
      // textTheme: TextTheme(
      //   subtitle1: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.textGray,
      //   ),
      // ),
    ).setCommonThemeElements();

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryD,
      scaffoldBackgroundColor: AppColors.primaryLightD,
      cardColor: AppColors.primaryDisabledD,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.black,
          backgroundColor: AppColors.accentD,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.accentD,
        ),
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    ).setCommonThemeElements();
