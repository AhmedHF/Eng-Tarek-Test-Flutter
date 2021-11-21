part of 'saving_cubit.dart';

abstract class SavingState extends Equatable {
  const SavingState();

  @override
  List<Object> get props => [];
}

class SavingInitial extends SavingState {}

// saving states

class SavingLoadingState extends SavingState {}

class SavingSuccessState extends SavingState {
  final int saving;
  const SavingSuccessState(this.saving);
}

class SavingErrorState extends SavingState {
  final String error;
  const SavingErrorState(this.error);
}
