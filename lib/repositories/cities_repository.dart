import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class CitiesRepository implements CitiesInterface {
  final CitiesDataProvider citiesDataProvider;
  const CitiesRepository(this.citiesDataProvider);

  @override
  Future<AppResponse> getCities(areaValue) {
    return citiesDataProvider.getCities(areaValue);
  }
}
