import 'package:value_client/models/index.dart';

abstract class SearchInterface {
  Future<AppResponse> getCategories();
  Future<AppResponse> getCouponTypes();
}
