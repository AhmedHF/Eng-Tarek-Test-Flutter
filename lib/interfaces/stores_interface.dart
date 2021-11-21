import 'package:value_client/models/index.dart';

abstract class StoresInterface {
  Future<AppResponse> getSlider();
  Future<AppResponse> getStores(query);
  Future<AppResponse> getStoreDetails(id);
}
