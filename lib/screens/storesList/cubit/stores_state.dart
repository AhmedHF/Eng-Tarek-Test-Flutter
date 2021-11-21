part of 'stores_cubit.dart';

abstract class StoresState extends Equatable {
  const StoresState();

  @override
  List<Object> get props => [];
}

class StoresInitial extends StoresState {}

class StoresLoadingState extends StoresState {}

class StoresSuccessState extends StoresState {
  final List<Map<String, dynamic>> stores;
  StoresSuccessState(this.stores);
}

class StoresLoadingNextPageState extends StoresState {}

class StoresErrorState extends StoresState {
  final String error;
  StoresErrorState(this.error);
}
