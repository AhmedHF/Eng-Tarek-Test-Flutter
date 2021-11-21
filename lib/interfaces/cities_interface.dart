import 'package:value_client/models/index.dart';

abstract class CitiesInterface {
  Future<AppResponse> getCities(value);
}
