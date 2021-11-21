import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'stores_slider_state.dart';

class StoresSliderCubit extends Cubit<StoresSliderState> {
  StoresSliderCubit() : super(StoresSliderInitial());

  static StoresSliderCubit get(context) => BlocProvider.of(context);
  static final dataProvider = new StoresDataProvider();
  static final StoresRepository repository = StoresRepository(dataProvider);

  /// get Slider data
  void getSlider() {
    emit(StoresSliderLoadingState());
    repository.getSlider().then(
      (value) {
        if (value.errorMessages != null) {
          emit(StoresSliderErrorState(value.errorMessages!));
        } else {
          List<SliderModel> slider = [];

          value.data.forEach((item) {
            slider.add(SliderModel(
              id: item['id'],
              image: item['image'],
            ));
          });
          emit(StoresSliderSuccessState(slider));
        }
      },
    );
  }
}
