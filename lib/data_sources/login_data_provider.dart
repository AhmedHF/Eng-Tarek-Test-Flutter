import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/models/login_res.dart';
import 'package:flutter/foundation.dart';

class LoginDataProvider {
  Future<AppResponse> login(Map<String, dynamic> values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.login,
      data: values,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.data = LoginResModel.fromJson(response.data);
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> logout(Map<String, dynamic> values) async {
    late final AppResponse response;

    await DioHelper.postFormData(
      url: NetworkConstants.logout,
      data: values,
    ).then(
      (value) {
        debugPrint('VALUE jjjjj : $value}', wrapWidth: 1024);
        response = AppResponse.fromJson(value.data);
        // response.data = LoginResModel.fromJson(response.data);
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }
}
