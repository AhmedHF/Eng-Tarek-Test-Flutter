import 'dart:io';

import 'package:value_client/core/helpers/index.dart';

class LanguageRepository {
  static String initLanguage() {
    final String defaultLocale = Platform.localeName;
    final String? lang = StorageHelper.getData(key: 'lang');
    final String appLang = lang ?? defaultLocale.split('_')[0];
    return appLang;
  }

  static void setLangData(lang) {
    StorageHelper.saveData(key: 'lang', value: lang);
  }
}
