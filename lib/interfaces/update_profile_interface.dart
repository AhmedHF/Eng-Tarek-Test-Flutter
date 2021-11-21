import 'package:value_client/models/index.dart';

abstract class UpdateProfileInterface {
  Future<AppResponse> updateProfile(values);
}
