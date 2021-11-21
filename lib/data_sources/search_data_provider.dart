import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class SearchDataProvider {
  Future<AppResponse> getCategories() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.categories,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        response = AppResponse.withErrorString(error.message);
      },
    );
    return response;
  }

  Future<AppResponse> getCouponTypes() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.couponTypes,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        response = AppResponse.withErrorString(error.message);
      },
    );
    return response;
  }
}
