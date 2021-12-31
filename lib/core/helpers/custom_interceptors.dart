import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:value_client/core/config/network_constants.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/core/services/navigation_service.dart';
import 'package:value_client/repositories/user.dart';
import 'package:value_client/widgets/index.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST => [${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE => [${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR => [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 411 &&
        err.requestOptions.path != NetworkConstants.login) {
      // debugPrint(
      //     'onError: ################################# 444  ${err.response?.data}');
      // debugPrint(
      //     'onError: ################################# ${err.response?.data['error'] ?? err.response?.data['errors']['error'] ?? 'eee error'}');
      AppSnackBar.showError(
          NavigationService.navigatorKey.currentContext!,
          err.response?.data['error'] ??
              err.response?.data['errors']['error'] ??
              '');
      debugPrint('########################## 111111');
      AppCubit cubit =
          AppCubit.get(NavigationService.navigatorKey.currentContext!);
      cubit.logout();
      return super.onError(err, handler);
    } else {
      return super.onError(err, handler);
    }
  }
}
