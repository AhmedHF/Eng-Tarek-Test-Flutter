import 'package:value_client/models/index.dart';

abstract class ResetPasswordInterface {
  Future<AppResponse> resetPassword(values);
}
