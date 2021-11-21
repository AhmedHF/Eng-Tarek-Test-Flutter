part of 'store_cubit.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreDetailsLoadingState extends StoreState {}

class StoreDetailsSuccessState extends StoreState {
  final Map<String, dynamic> storeDetails;
  StoreDetailsSuccessState(this.storeDetails);
}

class StoreDetailsErrorState extends StoreState {
  final String error;
  StoreDetailsErrorState(this.error);
}
