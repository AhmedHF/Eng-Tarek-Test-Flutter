import 'package:value_client/models/index.dart';

abstract class VerifyInterface {
  Future<AppResponse> verifyCode(values, token);
}
