import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class StoresRepository implements StoresInterface {
  final StoresDataProvider storesDataProvider;
  const StoresRepository(this.storesDataProvider);

  @override
  Future<AppResponse> getSlider() {
    return storesDataProvider.getSlider();
  }

  @override
  Future<AppResponse> getStores(query) {
    return storesDataProvider.getStores(query);
  }

  @override
  Future<AppResponse> getStoreDetails(id) {
    return storesDataProvider.getStoreDetails(id);
  }
}
