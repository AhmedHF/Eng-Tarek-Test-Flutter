import 'package:value_client/models/index.dart';

abstract class SignupInterface {
  Future<AppResponse> signup(values);
}
