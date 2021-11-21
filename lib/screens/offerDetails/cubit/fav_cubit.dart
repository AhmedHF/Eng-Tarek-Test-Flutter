import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  static FavCubit get(context) => BlocProvider.of(context);

  static final FavDataProvider dataProvider = new FavDataProvider();
  static final FavRepository repository = FavRepository(dataProvider);

  //toggleFav
  void toggleFav(values) {
    emit(ToggleFavLoadingState());
    final dataProvider = new FavDataProvider();
    final FavRepository repository = FavRepository(dataProvider);
    repository.toggleFav(values).then(
      (value) {
        print("🚀 ~ file: app_cubit.dart ToggleFav $value}");

        if (value.errorMessages != null) {
          emit(ToggleFavErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ToggleFavErrorState(value.errors!));
        } else
          emit(ToggleFavLoadedState(value.data));
        // this.getMyValueDetails(values['coupon_id'].toString());
      },
    );
  }
}
