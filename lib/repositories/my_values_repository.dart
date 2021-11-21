import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class MyValuesRepository implements MyValuesInterface {
  final MyValuesDataProvider myValuesDataProvider;

  const MyValuesRepository(this.myValuesDataProvider);

  @override
  Future<AppResponse> getMyValues(query) {
    return myValuesDataProvider.getMyValues(query);
  }

  @override
  Future<AppResponse> getValueById(String id) {
    return myValuesDataProvider.getValueById(id);
  }

  @override
  Future<AppResponse> getUserCouponById(String id) {
    return myValuesDataProvider.getUserCouponById(id);
  }

  @override
  Future<String> getQR(String id) {
    return myValuesDataProvider.getQR(id);
  }

  @override
  Future<AppResponse> sendGift(values) {
    return myValuesDataProvider.sendGift(values);
  }

  @override
  Future<AppResponse> getUserMemberShipDetails() {
    return myValuesDataProvider.getUserMemberShipDetails();
  }

  @override
  Future<AppResponse> getSaving() {
    return myValuesDataProvider.getSaving();
  }
}
