part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {
  final String message;
  ContactUsSuccessState(this.message);
}

class ContactUsErrorState extends ContactUsState {
  final String error;
  ContactUsErrorState(this.error);
}
