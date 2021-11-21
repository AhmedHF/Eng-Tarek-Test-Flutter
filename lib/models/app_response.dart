import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppResponse {
  dynamic data;
  dynamic meta;
  String? errors;
  String? errorMessages;
  int? statusCode;
  int? saving;

  AppResponse({
    this.data,
    this.meta,
    this.errors,
    this.errorMessages,
    this.statusCode,
    this.saving,
  });

  factory AppResponse.fromJson(Map<String, dynamic> json) => AppResponse(
        data: json['data'],
        errors: json['errors'],
        errorMessages: json['errorMessages'],
        statusCode: json['statusCode'],
        saving: json['saving'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'errors': errors,
        'errorMessages': errorMessages,
        'statusCode': statusCode,
      };

  static AppResponse withErrorResponse(Response error) {
    debugPrint('withErrorResponse =0=>> ${error.data["errors"]}');

    final AppResponse response = AppResponse();
    if (error.data["errors"].runtimeType != String &&
        error.data["errors"]['phone'] != null) {
      response.errors = error.data["errors"]['phone'][0];
    } else if (error.data["errors"].runtimeType != String &&
        error.data["errors"]['email'] != null) {
      response.errors = error.data["errors"]['email'][0];
    } else if (error.data["errors"].runtimeType != String &&
        error.data["errors"]['cart_id'] != null) {
      response.errorMessages = error.data["errors"]['cart_id'][0];
    } else if (error.data["errors"].runtimeType != String &&
        error.data["errors"]['error'] != null) {
      response.errors = error.data["errors"]['error'];
    } else {
      response.errors = error.data["errors"];
    }
    return response;
  }

  static AppResponse withErrorString(String error) {
    final AppResponse response = AppResponse();
    response.errorMessages = error;
    return response;
  }

  @override
  String toString() =>
      'data: $data errors: $errors errorMessages: $errorMessages statusCode: $statusCode';
}
