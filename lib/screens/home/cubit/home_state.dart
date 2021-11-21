part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class TopStoresLoadingState extends HomeState {}

class TopStoresSuccessState extends HomeState {
  final List<StoreModel> topStores;
  TopStoresSuccessState(this.topStores);
}

class TopStoresErrorState extends HomeState {
  final String error;
  TopStoresErrorState(this.error);
}
