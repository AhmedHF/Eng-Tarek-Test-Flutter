import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/repositories/index.dart';

part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  StoresCubit() : super(StoresInitial());

  static StoresCubit get(context) => BlocProvider.of(context);
  static final dataProvider = StoresDataProvider();
  static final StoresRepository repository = StoresRepository(dataProvider);

  final List<Map<String, dynamic>> stores = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  Map<String, dynamic> query = {
    'page': 1,
    'limit': 10,
  };

  /// get stores
  void getStores(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['limit'] = 10;
      query.addAll(queryData);
    }

    if (query['page'] == 1) {
      emit(StoresLoadingState());
    } else {
      emit(StoresLoadingNextPageState());
    }

    repository.getStores(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(StoresErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;
          List<Map<String, dynamic>> _stores = [];

          value.data.forEach((item) {
            _stores.add({
              "id": item['id'],
              "image": item['image'],
              "name": item['store_name'],
              "up_to": item['up_to'],
              "coupons_number": item['coupons_number'],
              "featured": item['featured'],
            });
          });
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            stores.addAll(_stores);
          } else {
            stores.clear();
            stores.addAll(_stores);
          }
          if (stores.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (stores.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('stores ${stores.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }
          emit(StoresSuccessState(stores));
        }
      },
    );
  }
}
