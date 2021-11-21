import 'package:value_client/models/index.dart';

abstract class LoginInterface {
  Future<AppResponse> login(Map<String, dynamic> values);
  Future<AppResponse> logout(Map<String, dynamic> values);
}
