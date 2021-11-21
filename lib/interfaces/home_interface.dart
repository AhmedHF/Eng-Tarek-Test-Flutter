import 'package:value_client/models/index.dart';

abstract class HomeInterface {
  Future<AppResponse> getSlider();
  Future<AppResponse> getTopStores(Map<String, dynamic> query);
  Future<AppResponse> getTopDiscount(Map<String, dynamic> query);
  Future<AppResponse> getTopRatedOffers(Map<String, dynamic> query);
}
