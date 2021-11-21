import 'package:value_client/models/index.dart';

abstract class MembershipInterface {
  Future<AppResponse> getMemberships();
  Future<AppResponse> checkout(Map<String, dynamic> data);
}
