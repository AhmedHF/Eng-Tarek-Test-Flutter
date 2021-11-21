import 'package:flutter/foundation.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class HomeDataProvider {
  Future<AppResponse> getSlider() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.slider,
      query: {
        'place': "slider",
      },
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        if (error.response) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getTopDiscount(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.coupons,
      query: {
        'top': 'desc',
        'limit': '10',
        ...query,
      },
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = response.data['meta'];
        response.data = response.data['data'];
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

  Future<AppResponse> getTopRatedOffers(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.coupons,
      query: {
        'top': 'desc',
        'rate': 'desc',
        'limit': '10',
        ...query,
      },
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = response.data['meta'];
        response.data = response.data['data'];
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

  Future<AppResponse> getTopStores(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.stores,
      query: {
        'rate': 'desc',
        'limit': '10',
        ...query,
      },
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = response.data['meta'];
        response.data = response.data['data'];
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
