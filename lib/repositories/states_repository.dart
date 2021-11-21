import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class StatesRepository implements StatesInterface {
  final StatesDataProvider statesDataProvider;
  const StatesRepository(this.statesDataProvider);

  @override
  Future<AppResponse> getStates(countryValue) {
    return statesDataProvider.getStates(countryValue);
  }
}
