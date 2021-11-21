import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/repositories/index.dart';

part 'saving_state.dart';

class SavingCubit extends Cubit<SavingState> {
  SavingCubit() : super(SavingInitial());

  static SavingCubit get(context) => BlocProvider.of(context);

  static final MyValuesDataProvider dataProvider = MyValuesDataProvider();
  static final MyValuesRepository repository = MyValuesRepository(dataProvider);

  /// get Saving
  void getSaving() {
    emit(SavingLoadingState());
    repository.getSaving().then(
      (value) {
        debugPrint('VALUE: $value', wrapWidth: 1024);
        if (value.errorMessages != null) {
          emit(SavingErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(SavingErrorState(value.errors!));
        } else {
          emit(SavingSuccessState(value.data ?? 0));
        }
      },
    );
  }
}
