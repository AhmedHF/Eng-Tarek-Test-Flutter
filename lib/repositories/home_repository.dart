import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class HomeRepository implements HomeInterface {
  final HomeDataProvider homeDataProvider;
  const HomeRepository(this.homeDataProvider);

  @override
  Future<AppResponse> getSlider() {
    return homeDataProvider.getSlider();
  }

  @override
  Future<AppResponse> getTopDiscount(query) {
    return homeDataProvider.getTopDiscount(query);
  }

  @override
  Future<AppResponse> getTopRatedOffers(query) {
    return homeDataProvider.getTopRatedOffers(query);
  }

  @override
  Future<AppResponse> getTopStores(query) {
    return homeDataProvider.getTopStores(query);
  }
}
