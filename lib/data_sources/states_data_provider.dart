import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';
import 'package:flutter/foundation.dart';

class StatesDataProvider {
  Future<AppResponse> getStates(countryValue) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.statesByCountry}/$countryValue',
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError((error) {
      debugPrint('error ================================ ${error?.message}');
      if (error?.response != null) {
        response = AppResponse.withErrorResponse(error.response);
      } else {
        response = AppResponse.withErrorString(error.message);
      }
    });
    return response;
  }
}
