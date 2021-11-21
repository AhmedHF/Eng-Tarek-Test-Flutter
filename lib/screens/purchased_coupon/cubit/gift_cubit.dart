import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/repositories/index.dart';
part 'gift_state.dart';

class GiftCubit extends Cubit<GiftStates> {
  GiftCubit() : super(AppInitial());
  static GiftCubit get(context) => BlocProvider.of(context);

  /// SendGift
  void sendGift(values) {
    emit(SendGiftLoadingState());
    final dataProvider = MyValuesDataProvider();
    final MyValuesRepository repository = MyValuesRepository(dataProvider);

    repository.sendGift(values).then(
      (value) {
        debugPrint('SendGift ==> ${value.toString()}');

        if (value.errorMessages != null) {
          emit(SendGiftErrorState(value.errorMessages!));
        } else {
          emit(SendGiftSuccessState(value.data));
        }
      },
    );
  }
}
