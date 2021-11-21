part of 'fav_cubit.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

class FavInitial extends FavState {}

// ToggleFav states

class ToggleFavLoadingState extends FavState {}

class ToggleFavLoadedState extends FavState {
  final String message;
  ToggleFavLoadedState(this.message);
}

class ToggleFavErrorState extends FavState {
  final String error;
  ToggleFavErrorState(this.error);
}
