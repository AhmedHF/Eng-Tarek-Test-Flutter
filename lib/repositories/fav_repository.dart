import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class FavRepository implements FavInterface {
  final FavDataProvider favDataProvider;
  FavRepository(this.favDataProvider);

  @override
  Future<AppResponse> toggleFav(Map<String, dynamic> data) {
    return favDataProvider.toggleFav(data);
  }
}
