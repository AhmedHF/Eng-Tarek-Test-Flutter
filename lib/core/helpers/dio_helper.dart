import 'package:dio/dio.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/custom_interceptors.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static late Dio dio;
  static const String baseUrl =
      NetworkConstants.baseUrlProd + NetworkConstants.apiPrefix;

  static init({String lang = 'en', String token = ''}) {
    debugPrint('token in init dio =>>$token');
    var options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept-Language': lang,
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
        'Accept': 'application/json',

        // 'Content-Type': 'multipart/form-data'
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    dio = Dio(options);
    dio.interceptors
      .add(CustomInterceptors());
      // ..add(LogInterceptor());
    // ..add(LogInterceptor(requestHeader: false, responseHeader: false));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> postFormData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    var formData = FormData.fromMap(data);
    if (token != '' && token != null) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
    return dio.post(
      url,
      data: formData,
      // queryParameters: query,
    );
  }

  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.delete(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
