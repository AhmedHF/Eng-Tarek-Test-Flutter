part of 'app_cubit.dart';

@immutable
abstract class AppStates {
  final Locale locale;
  final bool isDarkMode;
   const AppStates({this.locale =  const Locale('en'),  this.isDarkMode = false});
}

class AppInitial extends AppStates {
}

class AppChangeModeState extends AppStates {}

class AppLanguageState extends AppStates {}

class AppChangeBottomNavigationBarState extends AppStates {}

/// my values states

class MyValuesLoading extends AppStates {}

class MyValuesLoaded extends AppStates {
  final List<Value> values;
  MyValuesLoaded(this.values);
}

class MyValuesError extends AppStates {}

/// search map screen
class MapSearchLoadingState extends AppStates {}

class MapSearchSuccessState extends AppStates {
  final List<GeocodingResult> locations;
  MapSearchSuccessState(this.locations);
}

class MapSearchErrorState extends AppStates {
  final String error;
  MapSearchErrorState(this.error);
}

class MapSearchEmptyListState extends AppStates {
  final List<GeocodingResult> locations;
  MapSearchEmptyListState(this.locations);
}

//login states

class LoginLoadingState extends AppStates {}

class LoginLoadedState extends AppStates {
  late final UserModel loginData;
  late final String token;
  LoginLoadedState(this.loginData, this.token);
}

class LoginErrorState extends AppStates {
  final String error;
  LoginErrorState(this.error);
}

//verify states

class VerifyLoadingState extends AppStates {}

class VerifyLoadedState extends AppStates {
  // uncomment it
  late final Map<String, dynamic> verifyData;
  VerifyLoadedState(this.verifyData);
  // VerifyLoadedState();
}

class VerifyUserLoadedState extends AppStates {
  // uncomment it
  late final UserDataModel verifyData;
  VerifyUserLoadedState(this.verifyData);
  // VerifyLoadedState();
}

class VerifyErrorState extends AppStates {
  final String error;
  VerifyErrorState(this.error);
}
//resend states

class ResendLoadingState extends AppStates {}

class ResendLoadedState extends AppStates {
  // uncomment it
  late final Map<String, dynamic> data;
  // VerifyLoadedState(this.verifyData);
  ResendLoadedState(this.data);
}

class ResendErrorState extends AppStates {
  final String error;
  ResendErrorState(this.error);
}

//signup states
class SignupLoadingState extends AppStates {}

class SignupLoadedState extends AppStates {
  late final UserModel signupData;
  late final String token;
  SignupLoadedState(this.signupData, this.token);
}

class SignupErrorState extends AppStates {
  final String error;
  SignupErrorState(this.error);
}

//ForgetPassword states
class ForgetPasswordLoadingState extends AppStates {}

class ForgetPasswordLoadedState extends AppStates {
  late final Map<String, dynamic> data;
  ForgetPasswordLoadedState(this.data);
}

class ForgetPasswordErrorState extends AppStates {
  final String error;
  ForgetPasswordErrorState(this.error);
}

//resetPassword states
class ResetPasswordLoadingState extends AppStates {}

class ResetPasswordLoadedState extends AppStates {
  late final Map<String, dynamic> data;
  ResetPasswordLoadedState(this.data);
}

class ResetPasswordErrorState extends AppStates {
  final String error;
  ResetPasswordErrorState(this.error);
}

//ChangePassword states
class ChangePasswordLoadingState extends AppStates {}

class ChangePasswordLoadedState extends AppStates {
  late final String data;
  ChangePasswordLoadedState(this.data);
}

class ChangePasswordErrorState extends AppStates {
  final String error;
  ChangePasswordErrorState(this.error);
}

//UpdateMobile states
class UpdateMobileLoadingState extends AppStates {}

class UpdateMobileLoadedState extends AppStates {
  late final UserDataModel data;
  UpdateMobileLoadedState(this.data);
}

class UpdateMobileErrorState extends AppStates {
  final String error;
  UpdateMobileErrorState(this.error);
}

// update mobile verify states

class UpdateMobileVerifyLoadingState extends AppStates {}

class UpdateMobileVerifyUserLoadedState extends AppStates {
  late final UserDataModel verifyData;
  UpdateMobileVerifyUserLoadedState(this.verifyData);
}

class UpdateMobileVerifyErrorState extends AppStates {
  final String error;
  UpdateMobileVerifyErrorState(this.error);
}
// update profile states

class UpdateProfileLoadingState extends AppStates {}

class UpdateProfileLoadedState extends AppStates {
  late final UserDataModel verifyData;
  UpdateProfileLoadedState(this.verifyData);
}

class UpdateProfileErrorState extends AppStates {
  final String error;
  UpdateProfileErrorState(this.error);
}

// GetCountries states

class GetCountriesLoadingState extends AppStates {}

class GetCountriesLoadedState extends AppStates {
  late final List<dynamic> data;
  GetCountriesLoadedState(this.data);
}

class GetCountriesErrorState extends AppStates {
  final String error;
  GetCountriesErrorState(this.error);
}

// GetStates states
class GetStatesLoadingState extends AppStates {}

class GetStatesLoadedState extends AppStates {
  late final List<dynamic> data;
  GetStatesLoadedState(this.data);
}

class GetStatesErrorState extends AppStates {
  final String error;
  GetStatesErrorState(this.error);
}

// GetCities states

class GetCitiesLoadingState extends AppStates {}

class GetCitiesLoadedState extends AppStates {
  late final List<dynamic> data;
  GetCitiesLoadedState(this.data);
}

class GetCitiesErrorState extends AppStates {
  final String error;
  GetCitiesErrorState(this.error);
}

//Logout states

class LogoutLoadingState extends AppStates {}

class LogoutSuccessState extends AppStates {
  late final String message;
  LogoutSuccessState(this.message);
}

class LogoutErrorState extends AppStates {
  final String error;
  LogoutErrorState(this.error);
}

class SelectCountryState extends AppStates {
  SelectCountryState();
}
