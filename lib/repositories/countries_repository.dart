import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class CountriesRepository implements CountriesInterface {
  final CountriesDataProvider countriesDataProvider;
  const CountriesRepository(this.countriesDataProvider);

  @override
  Future<AppResponse> getCountries() {
    return countriesDataProvider.getCountries();
  }
}
