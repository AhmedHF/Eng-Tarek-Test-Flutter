import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class CountriesDataProvider {
  Future<AppResponse> getCountries() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.countries,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError((error) {
      if (error?.response != null) {
        response = AppResponse.withErrorResponse(error.response);
      } else {
        response = AppResponse.withErrorString(error.message);
      }
    });
    return response;
  }
}
