import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';
import 'package:flutter/foundation.dart';

class VerifyDataProvider {
  Future<AppResponse> verifyCode(values, token) async {
    late final AppResponse response;

    await DioHelper.postFormData(
            url: NetworkConstants.checkCode, data: values, token: token)
        .then(
      (value) {
        response = AppResponse.fromJson(value.data);
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
