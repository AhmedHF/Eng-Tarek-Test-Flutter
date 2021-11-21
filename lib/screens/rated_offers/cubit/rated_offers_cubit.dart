import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/utils/utils.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'rated_offers_state.dart';

class RatedOffersCubit extends Cubit<RatedOffersState> {
  RatedOffersCubit() : super(RatedOffersInitial());

  static RatedOffersCubit get(context) => BlocProvider.of(context);

  static final dataProvider = RatedOffersDataProvider();
  static final RatedOffersRepository repository =
      RatedOffersRepository(dataProvider);

  SortType sortBy = SortType.top;

  final List<DiscountModel> ratedOffers = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  Map<String, dynamic> query = {
    'page': 1,
    'limit': 10,
  };

  void setSortType(SortType type) {
    sortBy = type;
    emit(ChangeSortType(type));
  }

  /// get rated offers
  void getRatedOffers(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      query.clear();
      query['page'] = 1;
      query['limit'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      emit(RatedOffersLoadingState());
    } else {
      emit(RatedOffersLoadingNextPageState());
    }

    repository.getRatedOffers(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(RatedOffersErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;

          List<DiscountModel> _ratedOffers = [];

          value.data.forEach((item) {
            _ratedOffers.add(DiscountModel(
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

          debugPrint('_myValues ${_ratedOffers.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            ratedOffers.addAll(_ratedOffers);
          } else {
            ratedOffers.clear();
            ratedOffers.addAll(_ratedOffers);
          }
          if (ratedOffers.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (ratedOffers.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(RatedOffersSuccessState(ratedOffers));
        }
      },
    );
  }
}
