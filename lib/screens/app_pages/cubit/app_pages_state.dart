part of 'app_pages_cubit.dart';

abstract class AppPagesState extends Equatable {
  const AppPagesState();

  @override
  List<Object> get props => [];
}

class AppPagesInitial extends AppPagesState {}

// terms states

class TermsAndConditionsLoadingState extends AppPagesState {}

class TermsAndConditionsSuccessState extends AppPagesState {
  final AppPagesModel terms;
  TermsAndConditionsSuccessState(this.terms);
}

class TermsAndConditionsErrorState extends AppPagesState {
  final String error;
  TermsAndConditionsErrorState(this.error);
}

// privacy states

class PrivacyLoadingState extends AppPagesState {}

class PrivacySuccessState extends AppPagesState {
  final AppPagesModel privacy;
  PrivacySuccessState(this.privacy);
}

class PrivacyErrorState extends AppPagesState {
  final String error;
  PrivacyErrorState(this.error);
}

// About us states

class AboutUsLoadingState extends AppPagesState {}

class AboutUsSuccessState extends AppPagesState {
  final AppPagesModel aboutUs;
  AboutUsSuccessState(this.aboutUs);
}

class AboutUsErrorState extends AppPagesState {
  final String error;
  AboutUsErrorState(this.error);
}
