import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class RatedOffersDataProvider {
  Future<AppResponse> getRatedOffers(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.coupons,
      query: query,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = response.data['meta'];
        response.data = response.data['data'];
      },
    ).catchError(
      (error) {
        response = AppResponse.withErrorString(error.message);
      },
    );
    return response;
  }
}
