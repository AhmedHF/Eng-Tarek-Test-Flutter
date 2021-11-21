import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  static SliderCubit get(context) => BlocProvider.of(context);
  static final dataProvider = new HomeDataProvider();
  static final HomeRepository repository = HomeRepository(dataProvider);

  /// get Slider data
  void getSlider() {
    emit(SliderLoadingState());
    repository.getSlider().then(
      (value) {
        if (value.errorMessages != null) {
          emit(SliderErrorState(value.errorMessages!));
        } else {
          List<SliderModel> slider = [];

          value.data.forEach((item) {
            slider.add(SliderModel(
              id: item['id'],
              image: item['image'],
            ));
          });
          emit(SliderSuccessState(slider));
        }
      },
    );
  }
}
