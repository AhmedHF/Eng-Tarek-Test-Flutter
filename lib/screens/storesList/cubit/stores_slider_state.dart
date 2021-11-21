part of 'stores_slider_cubit.dart';

abstract class StoresSliderState extends Equatable {
  const StoresSliderState();

  @override
  List<Object> get props => [];
}

class StoresSliderInitial extends StoresSliderState {}

class StoresSliderLoadingState extends StoresSliderState {}

class StoresSliderSuccessState extends StoresSliderState {
  final List<SliderModel> storesSlider;
  StoresSliderSuccessState(this.storesSlider);
}

class StoresSliderErrorState extends StoresSliderState {
  final String error;
  StoresSliderErrorState(this.error);
}
