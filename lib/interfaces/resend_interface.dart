import 'package:value_client/models/index.dart';

abstract class ResendInterface {
  Future<AppResponse> resendCode(values);
}
