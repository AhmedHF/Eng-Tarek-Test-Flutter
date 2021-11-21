import 'package:value_client/models/index.dart';

abstract class RatedOffersInterface {
  Future<AppResponse> getRatedOffers(query);
}
