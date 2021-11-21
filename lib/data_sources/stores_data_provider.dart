import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class StoresDataProvider {
  Future<AppResponse> getSlider() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.slider,
      query: {
        'place': "inner",
      },
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

  Future<AppResponse> getStores(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.stores,
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

  Future<AppResponse> getStoreDetails(String id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.storeDetails}/$id',
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
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
