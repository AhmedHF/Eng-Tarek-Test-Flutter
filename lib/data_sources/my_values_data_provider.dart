import 'package:flutter/foundation.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class MyValuesDataProvider {
  Future<AppResponse> getUserMemberShipDetails() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.userMemberShip,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = response.saving;
        response.data = response.data;
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

  Future<AppResponse> getSaving() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.saving,
    ).then(
      (value) {
        debugPrint('VALUE===: $value', wrapWidth: 1024);
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

  Future<AppResponse> getMyValues(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.userCoupons,
      query: query,
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

  Future<AppResponse> getValueById(String id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.couponDetails}/$id',
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

  Future<AppResponse> getUserCouponById(String id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.userCouponDetails}/$id',
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

  Future<AppResponse> sendGift(values) async {
    late final AppResponse response;
    await DioHelper.postFormData(url: NetworkConstants.sendGift, data: values)
        .then(
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

  Future<String> getQR(String id) async {
    late final String response;
    await DioHelper.getData(
      url: '${NetworkConstants.qr}/$id',
    ).then(
      (value) {
        response = value.data.toString();
      },
    ).catchError(
      (error) {
        response = 'error happend';
      },
    );
    return response;
  }
}
