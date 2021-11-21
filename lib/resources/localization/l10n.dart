import 'dart:ui';
import 'package:flutter/material.dart';

const EN = const Locale('en');
const AR = const Locale('ar');

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
  ];

  static Locale getLocale(String code) {
    switch (code) {
      case 'ar':
        return AR;
      case 'en':
      default:
        return EN;
    }
  }
}
