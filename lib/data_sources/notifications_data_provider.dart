import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';
import 'package:flutter/foundation.dart';

class NotificationsDataProvider {
  Future<AppResponse> getNotifications(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.notifications,
      query: query,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.meta = value.data['meta'];
        response.data = value.data['data'];
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> readNotification(id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.readNotification}/$id',
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> removeNotification(id) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: '${NetworkConstants.removeNotification}/$id',
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');

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
