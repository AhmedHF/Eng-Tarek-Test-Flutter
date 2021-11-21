import 'dart:io';

import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class CartDataProvider {
  Future<AppResponse> getCartItems() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.cart,
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

  Future<AppResponse> addItemToCart(Map<String, dynamic> data) async {
    late final AppResponse response;
    await DioHelper.postFormData(
      url: NetworkConstants.addItemToCart,
      data: data,
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

  Future<AppResponse> updateItemInCart(Map<String, dynamic> data) async {
    late final AppResponse response;
    await DioHelper.postData(
      url: NetworkConstants.updateItemInCart,
      data: data,
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

  Future<AppResponse> deleteItemFromCart(int id) async {
    late final AppResponse response;
    await DioHelper.postData(
      url: NetworkConstants.deleteItemFromCart,
      data: {
        'cart_id': id,
      },
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

  Future<AppResponse> checkout(Map<String, dynamic> data) async {
    late final AppResponse response;
    await DioHelper.postData(
      url: NetworkConstants.checkout,
      data: data,
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

  Future<AppResponse> getCartTotalPrice() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.totalPrice,
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

  Future<AppResponse> getPaymentMethods() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.paymentMethods,
      query: {'type': Platform.isAndroid ? 'android' : 'ios'},
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
