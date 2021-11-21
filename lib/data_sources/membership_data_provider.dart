import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';

class MembershipDataProvider {
  Future<AppResponse> getMemberships() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.memberships,
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

  Future<AppResponse> checkout(Map<String, dynamic> data) async {
    late final AppResponse response;
    await DioHelper.postData(
      url: NetworkConstants.subscribe,
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
}
