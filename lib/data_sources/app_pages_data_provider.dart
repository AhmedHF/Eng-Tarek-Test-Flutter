import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';
import 'package:flutter/foundation.dart';

class AppPagesDataProvider {
  Future<AppResponse> getPageData(url) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: url,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.data = AppPagesModel.fromJson(response.data);
      },
    ).catchError(
      (error) {
        response = AppResponse.withErrorString(error.message);
        debugPrint('================================ ${error.message}');
      },
    );
    return response;
  }
}
