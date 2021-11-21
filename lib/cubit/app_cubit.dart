import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/data_sources/login_data_provider.dart';
import 'package:value_client/entities/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/country_repository.dart';
import 'package:value_client/repositories/index.dart';
import 'package:value_client/repositories/language.dart';
import 'package:value_client/repositories/login_repository.dart';
import 'package:value_client/repositories/user.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/screens/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:google_maps_webservice/geocoding.dart";

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  // app language
  Locale locale = Locale(LanguageRepository.initLanguage());

  void setLang(Locale _locale) {
    debugPrint('==== setLang $_locale');
    locale = _locale;
    emit(AppLanguageState());
  }

  /// get the current language as string like ar ,en
  String getCurrentLanguage(context) {
    Locale myLocale = Localizations.localeOf(context);
    return myLocale.toLanguageTag();
  }

  bool isRTL(context) {
    Locale myLocale = Localizations.localeOf(context);
    // debugPrint('myLocale ' + myLocale.toLanguageTag());
    return myLocale.toLanguageTag() == 'ar';
  }

  /// User Data
  UserDataModel userData = UserRepository.initUserData();

  void setUser(UserDataModel currentUserData) {
    debugPrint('==== setUser $currentUserData');
    userData = currentUserData;
  }

  /// country id
  String countryId = CounrtyRepository.initCounrty();

  Future<void> setCountryId(String id) async {
    debugPrint('ID------- => : $id}', wrapWidth: 1024);
    countryId = id;
    emit(SelectCountryState());
    await StorageHelper.saveData(key: 'countryId', value: id);
  }

  ConnectivityResult connectionStatus = ConnectivityResult.none;
  Future<void> changeConnectionStatus(connectionStatus) async {
    debugPrint('CONNECTIONSTATUS: $connectionStatus}', wrapWidth: 1024);
    connectionStatus = connectionStatus;
  }

  // theme
  bool isDarkTheme = false;

  void changeAppMode() {
    isDarkTheme = !isDarkTheme;
    emit(AppChangeModeState());
  }
  // end theme

  // Home layout bottomNavigationBar
  int selectedIndex = 0;
  List<BottomNavigationBarItem> getItems(context) {
    List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.home),
        label: AppLocalizations.of(context)!.home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.cart),
        label: AppLocalizations.of(context)!.cart,
      ),
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.my_value),
        label: AppLocalizations.of(context)!.my_value,
      ),
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.menu),
        label: AppLocalizations.of(context)!.menu,
      ),
    ];
    return items;
  }

  List<String> getTitles(context) {
    List<String> titles = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.cart,
      AppLocalizations.of(context)!.my_value,
      AppLocalizations.of(context)!.menu,
    ];
    return titles;
  }

  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const CartScreen(),
    const MyValueScreen(),
    const MenuScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    emit(AppChangeBottomNavigationBarState());
  }

  Future<List<GeocodingResult>> getMaopSearchData(String value) async {
    emit(MapSearchLoadingState());

    final geocoding = GoogleMapsGeocoding(apiKey: AppConfiguration.API_KEY);

    GeocodingResponse response =
        await geocoding.searchByAddress(value, language: locale.languageCode);
    if (response.status == 'OK') {
      emit(MapSearchSuccessState(response.results));
    }
    if (response.errorMessage != null) {
      emit(MapSearchErrorState(response.errorMessage!));
    }
    return response.results;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //Login
  void login(Map<String, dynamic> values) async {
    String? token = await messaging.getToken();
    setCountryId(values['country_id']);
    values['device_token'] = token;
    debugPrint('VALUES: $values}', wrapWidth: 1024);
    emit(LoginLoadingState());
    final dataProvider = LoginDataProvider();
    final LoginRepository repository = LoginRepository(dataProvider);
    repository.login(values).then(
      (value) {
        // print("🚀 TOKEN  ${value.data}");
        if (value.errorMessages != null) {
          emit(LoginErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(LoginErrorState(value.errors!));
        } else {
          emit(LoginLoadedState(value.data.user, value.data.token));
        }
      },
    );
  }

  //Verify
  void verifyCode(values, token) {
    emit(VerifyLoadingState());
    final dataProvider = VerifyDataProvider();
    final VerifyRepository repository = VerifyRepository(dataProvider);
    repository.verifyCode(values, token).then(
      (value) {
        if (value.errorMessages != null) {
          emit(VerifyErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(VerifyErrorState(value.errors!));
        } else {
          if (value.data["user"] != null) {
            emit(VerifyUserLoadedState(UserDataModel.fromJson(value.data)));
          } else {
            emit(VerifyLoadedState(value.data));
          }
        }
      },
    );
  }

//Resend
  void resendCode(values) {
    emit(ResendLoadingState());
    final dataProvider = ResendDataProvider();
    final ResendRepository repository = ResendRepository(dataProvider);
    repository.resendCode(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(ResendErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ResendErrorState(value.errors!));
        } else {
          emit(ResendLoadedState(value.data));
        }
      },
    );
  }

  //Signup
  void signup(Map<String, dynamic> values) async {
    String? token = await messaging.getToken();
    setCountryId(values['country_id']);
    values['device_token'] = token;
    debugPrint('VALUES: $values}', wrapWidth: 1024);
    emit(SignupLoadingState());
    final dataProvider = SignupDataProvider();
    final SignupRepository repository = SignupRepository(dataProvider);
    repository.signup(values).then(
      (value) {
        // print("🚀 TOKEN  ${value.data}");
        if (value.errorMessages != null) {
          emit(SignupErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(SignupErrorState(value.errors!));
        } else {
          emit(SignupLoadedState(value.data.user, value.data.token));
        }
      },
    );
  }

//ForgetPassword
  void forgetPassword(values) {
    emit(ForgetPasswordLoadingState());
    final dataProvider = ForgetPasswordDataProvider();
    final ForgetPasswordRepository repository =
        ForgetPasswordRepository(dataProvider);
    repository.forgetPassword(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(ForgetPasswordErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ForgetPasswordErrorState(value.errors!));
        } else {
          emit(ForgetPasswordLoadedState(value.data));
        }
      },
    );
  }

  //ResetPassword
  void resetPassword(values) {
    emit(ResetPasswordLoadingState());
    final dataProvider = ResetPasswordDataProvider();
    final ResetPasswordRepository repository =
        ResetPasswordRepository(dataProvider);
    repository.resetPassword(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(ResetPasswordErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ResetPasswordErrorState(value.errors!));
        } else {
          emit(ResetPasswordLoadedState(value.data));
        }
      },
    );
  }

  //ChangePassword
  void changePassword(values) {
    emit(ChangePasswordLoadingState());
    final dataProvider = ChangePasswordDataProvider();
    final ChangePasswordRepository repository =
        ChangePasswordRepository(dataProvider);
    repository.changePassword(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(ChangePasswordErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ChangePasswordErrorState(value.errors!));
        } else {
          emit(ChangePasswordLoadedState(value.data));
        }
      },
    );
  }

  //UpdateMobile
  void updateMobile(values) {
    emit(UpdateMobileLoadingState());
    final dataProvider = UpdateMobileDataProvider();
    final UpdateMobileRepository repository =
        UpdateMobileRepository(dataProvider);
    repository.updateMobile(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(UpdateMobileErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UpdateMobileErrorState(value.errors!));
        } else {
          emit(UpdateMobileLoadedState(UserDataModel.fromJson(value.data)));
        }
      },
    );
  }

  //UpdateMobile Verify
  void updateMobileVerify(values) {
    emit(UpdateMobileVerifyLoadingState());
    final dataProvider = UpdateMobileVerifyProvider();
    final UpdateMobileVerifyRepository repository =
        UpdateMobileVerifyRepository(dataProvider);
    repository.updateMobileVerify(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(UpdateMobileVerifyErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UpdateMobileVerifyErrorState(value.errors!));
        } else {
          emit(UpdateMobileVerifyUserLoadedState(
              UserDataModel.fromJson(value.data)));
        }
      },
    );
  }

  //Update Profile
  void updateProfile(values) {
    emit(UpdateProfileLoadingState());
    final dataProvider = UpdateProfileProvider();
    final UpdateProfileRepository repository =
        UpdateProfileRepository(dataProvider);
    repository.updateProfile(values).then(
      (value) async {
        if (value.errorMessages != null) {
          emit(UpdateProfileErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UpdateProfileErrorState(value.errors!));
        } else {
          UserDataModel verifyData = UserDataModel.fromJson(value.data);
          debugPrint('VERIFYDATA ====== : $verifyData}', wrapWidth: 1024);
          setUser(
              UserDataModel(user: verifyData.user, token: verifyData.token));
          await StorageHelper.saveObject(
            key: 'userdata',
            object: UserDataModel(
              token: verifyData.token,
              user: UserModel(
                id: verifyData.user!.id,
                name: verifyData.user!.name,
                email: verifyData.user!.email,
                phone: verifyData.user!.phone,
                image: verifyData.user!.image,
                lat: verifyData.user!.lat,
                lng: verifyData.user!.lng,
                verificationCode: verifyData.user!.verificationCode,
                isActive: verifyData.user!.isActive,
                verified: verifyData.user!.verified,
                country: verifyData.user!.country,
              ),
            ),
          );
          String initLanguage = LanguageRepository.initLanguage();
          DioHelper.init(lang: initLanguage, token: verifyData.token as String);

          emit(UpdateProfileLoadedState(UserDataModel.fromJson(value.data)));
        }
      },
    );
  }

  List<dynamic> countries = [];
  //getCountries
  void getCountries() {
    emit(GetCountriesLoadingState());
    final dataProvider = CountriesDataProvider();
    final CountriesRepository repository = CountriesRepository(dataProvider);
    repository.getCountries().then(
      (value) {
        countries = [];
        if (value.errorMessages != null) {
          emit(GetCountriesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetCountriesErrorState(value.errors!));
        } else {
          countries.addAll(value.data);
          emit(GetCountriesLoadedState(value.data));
        }
      },
    );
  }

  //getStates
  void getStates(countryValue) {
    emit(GetStatesLoadingState());
    final dataProvider = StatesDataProvider();
    final StatesRepository repository = StatesRepository(dataProvider);
    repository.getStates(countryValue).then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetStatesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetStatesErrorState(value.errors!));
        } else {
          emit(GetStatesLoadedState(value.data));
        }
      },
    );
  }

  //getCities
  void getCities(areaValue) {
    emit(GetCitiesLoadingState());
    final dataProvider = CitiesDataProvider();
    final CitiesRepository repository = CitiesRepository(dataProvider);
    repository.getCities(areaValue).then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetCitiesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetCitiesErrorState(value.errors!));
        } else {
          emit(GetCitiesLoadedState(value.data));
        }
      },
    );
  }

  /// Logout
  void logout() async {
    String? token = await messaging.getToken();
    Map<String, dynamic> values = {
      'device_token': token,
    };
    debugPrint('VALUES: $values}', wrapWidth: 1024);
    emit(LogoutLoadingState());
    final dataProvider = LoginDataProvider();
    final LoginRepository repository = LoginRepository(dataProvider);
    repository.logout(values).then(
      (value) {
        debugPrint("🚀🚀🚀🚀🚀🚀 TOKEN  $value}");
        if (value.errorMessages != null) {
          emit(LogoutErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(LogoutErrorState(value.errors!));
        } else {
          UserRepository.logout();
          emit(LogoutSuccessState(value.data));
        }
      },
    );
  }
}
