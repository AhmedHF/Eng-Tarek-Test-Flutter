import 'package:value_client/models/index.dart';

abstract class FavInterface {
  Future<AppResponse> toggleFav(Map<String, dynamic> data);
}
