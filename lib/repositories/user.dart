import 'package:flutter/material.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:value_client/core/services/navigation_service.dart';
import 'package:value_client/repositories/language.dart';
import 'package:value_client/routes/app_routes.dart';

class UserRepository {
  static UserDataModel initUserData() {
    debugPrint('APPP User data ');
    UserDataModel userData = const UserDataModel();

    if (StorageHelper.getObject(key: 'userdata') != false) {
      userData =
          UserDataModel.fromJson(StorageHelper.getObject(key: 'userdata'));

      debugPrint('userData -------+ ==> ${userData.user.toString()}');
      debugPrint('token ------+ ==> ${userData.token.toString()}');

      if (userData.toJson().isNotEmpty &&
          userData.user!.isActive! &&
          userData.user!.verified!) {
        return userData;
      }
    }
    return userData;
  }

  static void logout() async {
    debugPrint('log out === ***************************************>');
    String initLanguage = LanguageRepository.initLanguage();
    DioHelper.init(lang: initLanguage, token: '');
    AppCubit cubit =
        AppCubit.get(NavigationService.navigatorKey.currentContext!);
    cubit.setUser(const UserDataModel());
    await StorageHelper.remove(key: 'countryId');
    await StorageHelper.remove(key: 'userdata');

    Navigator.of(NavigationService.navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
    debugPrint('########################## logout ');
  }
}
