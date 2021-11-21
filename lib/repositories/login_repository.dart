import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class LoginRepository implements LoginInterface {
  final LoginDataProvider loginDataProvider;
  const LoginRepository(this.loginDataProvider);
  @override
  Future<AppResponse> login(Map<String, dynamic> values) {
    return loginDataProvider.login(values);
  }

  @override
  Future<AppResponse> logout(Map<String, dynamic> values) {
    return loginDataProvider.logout(values);
  }
}
