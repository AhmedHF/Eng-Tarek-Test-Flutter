import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveObject(
      {required String key, required dynamic object}) async {
    String value = jsonEncode(object.toJson());
    return await sharedPreferences.setString(key, value);
  }

  static dynamic getObject({required String key}) {
    final json = sharedPreferences.getString(key);
    if (json != null) {
      return jsonDecode(json);
    } else {
      return false;
    }
  }

  static Future<bool> remove({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
