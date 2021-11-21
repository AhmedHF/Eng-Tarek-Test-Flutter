import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  static final dataProvider = HomeDataProvider();
  static final HomeRepository repository = HomeRepository(dataProvider);

  /// get Top stores
  void getTopStores(countryId) {
    emit(TopStoresLoadingState());
    Map<String, dynamic> query = {};
    if (countryId != -1) {
      query.addAll({'country_id': countryId});
    }
    repository.getTopStores(query).then(
      (value) {
        debugPrint('vv${value.data.toString()}');
        if (value.errorMessages != null) {
          emit(TopStoresErrorState(value.errorMessages!));
        } else {
          List<StoreModel> topStores = [];

          value.data.forEach((item) {
            topStores.add(StoreModel(
                id: item['id'],
                image: item['image'],
                name: item['store_name']));
          });
          emit(TopStoresSuccessState(topStores));
        }
      },
    );
  }
}
