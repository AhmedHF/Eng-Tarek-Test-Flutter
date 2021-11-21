import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'top_offers_state.dart';

class TopOffersCubit extends Cubit<TopOffersState> {
  TopOffersCubit() : super(TopOffersInitial());
  static TopOffersCubit get(context) => BlocProvider.of(context);
  static final dataProvider = HomeDataProvider();
  static final HomeRepository repository = HomeRepository(dataProvider);

  /// get Top discount
  void getTopRatedOffers(countryId) {
    debugPrint('--------- COUNTRYIDD: $countryId}', wrapWidth: 1024);
    emit(TopRatedOffersLoadingState());
    Map<String, dynamic> query = {};
    if (countryId != -1) {
      query.addAll({'country_id': countryId});
    }
    repository.getTopRatedOffers(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(TopRatedOffersErrorState(value.errorMessages!));
        } else {
          List<DiscountModel> topRatedOffers = [];

          value.data.forEach((item) {
            topRatedOffers.add(DiscountModel(
              id: item['id'],
              name: item['name'],
              description: item['description'],
              offer: item['discount_amount'],
              image: item['image'],
              expire: item['expire'],
              expireDate: item['to_date'],
              price: item['price'],
              priceBeforeDiscount: item['price_before_discount'],
              storeName: item['store']['store_name'],
              storeImage: item['store']['image'],
            ));
          });
          emit(TopRatedOffersSuccessState(topRatedOffers));
        }
      },
    );
  }
}
