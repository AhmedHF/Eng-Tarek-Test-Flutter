import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:value_client/widgets/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  String countryCode = '+966';
  String? countryId;
  late List<dynamic> countries = [];
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _saveForm(cubit) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    // _form.currentState!.save();
    await cubit.setCountryId(countryId);
    cubit.login({
      "phone": phone.text,
      "password": password.text,
      "country_id": countryId,
    });
  }

  showCountryPicker(BuildContext context) {
    if (countries.isEmpty) {
      AppSnackBar.showError(
          context, AppLocalizations.of(context)!.there_is_no_countries);
      return;
    }
    var countriesData = countries
        .map((e) => PickerItem(text: Text(e['name']), value: e['id']))
        .toList();
    Picker(
      adapter: PickerDataAdapter(data: countriesData),
      title: Text(AppLocalizations.of(context)!.country),
      cancelText: AppLocalizations.of(context)!.cancel,
      confirmText: AppLocalizations.of(context)!.confirm,
      onConfirm: (Picker picker, List value) {
        var selectedCountry = countries.firstWhere(
            (element) => element['id'] == picker.getSelectedValues()[0]);
        setState(() {
          countryCode = selectedCountry['code'];
          countryId = picker.getSelectedValues()[0].toString();
        });
      },
    ).showModal(context);
  }

  @override
  void initState() {
    super.initState();
    AppCubit cubit = AppCubit.get(context);
    cubit.getCountries();
  }

  Widget _buildBodyItem() {
    return Stack(
      children: <Widget>[
        Image.asset(
          AppImages.background,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: double.infinity,
                  height: 110,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 25),
                Form(
                  key: _form,
                  child: AutofillGroup(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autofillHints: const [
                              AutofillHints.telephoneNumberNational
                            ],
                            controller: phone,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.phoneNumber,
                              filled: true,
                              fillColor: AppColors.white,
                              prefixIcon: SizedBox(
                                width: 60,
                                child: GestureDetector(
                                  onTap: () {
                                    showCountryPicker(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      countryCode,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: AppColors.primaryL,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // prefixIcon: const Icon(
                              //   AppIcons.telephone,
                              //   color: AppColors.primaryL,
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelStyle: const TextStyle(color: Colors.grey),
                              errorStyle: const TextStyle(
                                color: AppColors.accentL,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            cursorColor: AppColors.primaryL,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              } else if (!value.isValidMinLength(7)) {
                                return AppLocalizations.of(context)!
                                    .at_least_7_num;
                              } else if (!value.isValidMaxLength(15)) {
                                return AppLocalizations.of(context)!
                                    .at_most_15_num;
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.password,
                              filled: true,
                              fillColor: AppColors.white,
                              prefixIcon: const Icon(
                                AppIcons.key,
                                color: AppColors.primaryL,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.primaryL,
                                ),
                                onPressed: _toggle,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelStyle: const TextStyle(color: Colors.grey),
                              errorStyle: const TextStyle(
                                color: AppColors.accentL,
                              ),
                            ),
                            autofillHints: const [AutofillHints.password],
                            onEditingComplete: () =>
                                TextInput.finishAutofillContext(),
                            cursorColor: AppColors.primaryL,
                            focusNode: _passwordFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm(cubit);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              } else if (!value.isValidPassword) {
                                return AppLocalizations.of(context)!
                                    .password_validations;
                              } else if (!value.isValidMinLength(8)) {
                                return AppLocalizations.of(context)!
                                    .at_least_7_char;
                              } else if (!value.isValidMaxLength(15)) {
                                return AppLocalizations.of(context)!
                                    .at_most_15_char;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.forgetPasswordScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forget_password_q,
                          style: const TextStyle(
                            color: AppColors.accentL,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                AppButton(
                  loading: state is LoginLoadingState,
                  title: AppLocalizations.of(context)!.continue_btn,
                  onPressed: () {
                    _saveForm(cubit);
                  },
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 350,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.selectCountryScreen);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     AppRoutes.appHome, (route) => false);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.guest_view,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.signupScreen);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.do_not_have_account_q,
                    style: const TextStyle(color: AppColors.accentL),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  AppLocalizations.of(context)!
                      .by_creating_an_account_you_agree_to_our,
                  style: const TextStyle(color: AppColors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.termsScreen);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.terms_of_service,
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.and,
                      style: const TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.privacyScreen);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.privacy_policy,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetCountriesLoadedState && countryId == null) {
          countries = state.data;
          countryCode = countries[0]['code'];
          countryId = countries[0]['id'].toString();
        }
        if (state is LoginErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is LoginLoadedState) {
        
          debugPrint('user=====${state.loginData}');
          debugPrint('token=====${state.loginData}');

          if (!state.loginData.isActive!) {
            AppSnackBar.showError(
                context, AppLocalizations.of(context)!.user_inactive);
          } else if (state.loginData.verified!) {
            String initLanguage = LanguageRepository.initLanguage();
            DioHelper.init(lang: initLanguage, token: state.token);
            BlocProvider.of<AppCubit>(context).setUser(
                UserDataModel(user: state.loginData, token: state.token));

            StorageHelper.saveObject(
              key: 'userdata',
              object: UserDataModel(
                token: state.token,
                user: UserModel(
                  id: state.loginData.id,
                  name: state.loginData.name,
                  email: state.loginData.email,
                  phone: state.loginData.phone,
                  image: state.loginData.image,
                  lat: state.loginData.lat,
                  lng: state.loginData.lng,
                  verificationCode: state.loginData.verificationCode,
                  isActive: state.loginData.isActive,
                  verified: state.loginData.verified,
                  country: state.loginData.country,
                ),
              ),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.appHome, (route) => false);
          } else {
            Navigator.of(context).pushNamed(
              AppRoutes.verifyCodeScreen,
              arguments: [
                AppLocalizations.of(context)!.verify_phone_number,
                AppRoutes.verifiedScreen,
                state.loginData.phone,
                state.loginData.verificationCode,
                state.token,
                countryId,
              ],
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: NetworkSensitive(child: _buildBodyItem()),
        );
      },
    );
  }
}



