import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class RatedOffersRepository implements RatedOffersInterface {
  final RatedOffersDataProvider ratedOffersDataProvider;
  const RatedOffersRepository(this.ratedOffersDataProvider);

  @override
  Future<AppResponse> getRatedOffers(query) {
    return ratedOffersDataProvider.getRatedOffers(query);
  }
}
