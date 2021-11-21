part of 'slider_cubit.dart';

abstract class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoadingState extends SliderState {}

class SliderSuccessState extends SliderState {
  final List<SliderModel> slider;
  SliderSuccessState(this.slider);
}

class SliderErrorState extends SliderState {
  final String error;
  SliderErrorState(this.error);
}
