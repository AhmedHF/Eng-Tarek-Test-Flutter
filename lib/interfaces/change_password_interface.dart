import 'package:value_client/models/index.dart';

abstract class ChangePasswordInterface {
  Future<AppResponse> changePassword(values);
}
