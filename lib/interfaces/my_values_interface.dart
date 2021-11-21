import 'package:value_client/models/index.dart';

abstract class MyValuesInterface {
  Future<AppResponse> getUserMemberShipDetails();
  Future<AppResponse> getMyValues(query);
  Future<AppResponse> getValueById(String id);
  Future<AppResponse> getUserCouponById(String id);
  Future<String> getQR(String id);
  Future<AppResponse> sendGift(values);
  Future<AppResponse> getSaving();
}
