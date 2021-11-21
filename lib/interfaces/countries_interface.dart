import 'package:value_client/models/index.dart';

abstract class CountriesInterface {
  Future<AppResponse> getCountries();
}
