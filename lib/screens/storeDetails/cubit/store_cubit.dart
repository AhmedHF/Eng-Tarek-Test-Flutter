import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/repositories/index.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  static StoreCubit get(context) => BlocProvider.of(context);

  static final StoresDataProvider dataProvider = StoresDataProvider();
  static final StoresRepository repository = StoresRepository(dataProvider);

  /// get my value details
  void getStoreDetails(id) {
    debugPrint('enter here');
    emit(StoreDetailsLoadingState());
    repository.getStoreDetails(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(StoreDetailsErrorState(value.errorMessages!));
        } else {
          emit(StoreDetailsSuccessState(value.data));
        }
      },
    );
  }
}
