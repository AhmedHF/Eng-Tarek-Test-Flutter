import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:location/location.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/widgets/index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool agreedToTerms = false;
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  double lat = 0.0;
  double lng = 0.0;

  String address = '';

  String countryCode = '+966';
  String? countryId;
  late List<dynamic> countries = [];

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  // void _toggleLoading(v) {
  //   setState(() {
  //     loading = v;
  //   });
  // }
  void _saveForm(cubit) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    await cubit.setCountryId(countryId);
    cubit.signup({
      "phone": phone.text,
      "password": password.text,
      "password_confirmation": confirmpassword.text,
      // "name": name.text,
      // "email": email.text,
      "terms": 1,
      "lat": lat,
      "lng": lng,
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
        setState(
          () {
            countryCode = selectedCountry['code'];
            countryId = picker.getSelectedValues()[0].toString();
          },
        );
      },
    ).showModal(context);
  }

  @override
  void initState() {
    super.initState();
    AppCubit cubit = AppCubit.get(context);
    cubit.getCountries();
    checkPermission();
  }

  final Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;

  Future<void> checkPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      // _serviceEnabled = await location.requestService();
      // if (!_serviceEnabled) {
      //   Navigator.of(context).pop();
      //   return;
      // }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // _permissionGranted = await location.requestPermission();
      // if (_permissionGranted != PermissionStatus.granted) {
      //   Navigator.of(context).pop();
      //   return;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetCountriesLoadedState && countryId == null) {
          debugPrint('GetCountriesLoadedState $state');
          countries = state.data;
          countryCode = countries[0]['code'];
          countryId = countries[0]['id'].toString();
        }
        if (state is SignupErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is SignupLoadedState) {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.verifyCodeScreen,
            arguments: [
              AppLocalizations.of(context)!.verify_phone_number,
              AppRoutes.verifiedScreen,
              state.signupData.phone,
              state.signupData.verificationCode,
              state.token,
              countryId,
            ],
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: NetworkSensitive(
            child: Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    AppImages.background,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.create_account,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.account_info,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 50),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            controller: phone,
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.phoneNumber,
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
                              errorStyle: const TextStyle(
                                color: AppColors.accentL,
                              ),
                            ),
                            // The validator receives the text that the user has entered.
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
                        ),

                        const SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          controller: password,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.password,
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
                            errorStyle: const TextStyle(
                              color: AppColors.accentL,
                            ),
                          ),
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

                        const SizedBox(height: 15),

                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureTextConfirm,
                          controller: confirmpassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.confirm_password,
                            prefixIcon: const Icon(
                              AppIcons.key,
                              color: AppColors.primaryL,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureTextConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryL,
                              ),
                              onPressed: _toggleConfirm,
                            ),
                            errorStyle: const TextStyle(
                              color: AppColors.accentL,
                            ),
                          ),
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
                            } else if (password.text != confirmpassword.text) {
                              return AppLocalizations.of(context)!
                                  .password_not_match;
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: 15),

                        TextFormField(
                          readOnly: false,
                          controller: addressController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await checkPermission();
                            if (_permissionGranted ==
                                PermissionStatus.granted) {
                              pushMap();
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: AppLocalizations.of(context)!
                                        .detect_locations,
                                    onPressedYes: () {
                                      Navigator.pop(context, 'Ok');
                                      pushMap();
                                    },
                                  );
                                },
                              );
                            }
                          },
                          maxLines: address.length > 50
                              ? 3
                              : address.length > 25
                                  ? 2
                                  : 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.none,
                          decoration: InputDecoration(
                            hintText: address != ''
                                ? address
                                : AppLocalizations.of(context)!.open_map,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            prefixIcon: const Icon(
                              AppIcons.map,
                              color: AppColors.primaryL,
                            ),
                            suffixIcon: const Icon(
                              Icons.my_location,
                              color: AppColors.primaryL,
                            ),
                            errorStyle: const TextStyle(
                              color: AppColors.accentL,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        FormField<bool>(
                          initialValue: false,
                          validator: (value) {
                            if (value == false) {
                              return AppLocalizations.of(context)!
                                  .agree_terms_and_services;
                            }
                            return null;
                          },
                          builder: (formFieldState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment:MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                        checkColor: AppColors.secondaryL,
                                        activeColor: AppColors.white,
                                        value: agreedToTerms,
                                        onChanged: (value) {
                                          // When the value of the checkbox changes,
                                          // update the FormFieldState so the form is
                                          // re-validated.
                                          formFieldState.didChange(value);
                                          setState(() {
                                            agreedToTerms = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .by_creating_an_account_you_agree_to_our,
                                          style: const TextStyle(
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    AppRoutes.termsScreen);
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .terms_of_service,
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.and,
                                              style: const TextStyle(
                                                color: AppColors.white,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    AppRoutes.privacyScreen);
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .privacy_policy,
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                if (!formFieldState.isValid)
                                  Text(
                                    formFieldState.errorText ?? "",
                                    style: const TextStyle(
                                      color: AppColors.accentL,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 15),
                        // AppInput(
                        //   controller: confirmpassword,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   secure: true,
                        //   validations: (value) {
                        //     if (value!.isValidPassword) {
                        //       return null;
                        //     } else {
                        //       return 'Password must contain an uppercase, lowercase, \nnumeric digit and special character';
                        //     }
                        //   },
                        // ),
                        AppButton(
                          loading: state is SignupLoadingState,
                          onPressed: () {
                            // Navigator.of(context).pushNamed(
                            //   AppRoutes.verifyCodeScreen,
                            //   arguments: [
                            //     AppLocalizations.of(context)!.verify_phone_number,
                            //     AppRoutes.verifiedScreen
                            //   ],
                            // );
                            _saveForm(cubit);
                          },
                          title: AppLocalizations.of(context)!.next,
                        ),

                        const SizedBox(height: 15),

                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.loginScreen);
                            // Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.have_account,
                            style: const TextStyle(color: AppColors.accentL),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> pushMap() async {
    final result = await Navigator.of(context).pushNamed(
      AppRoutes.mapScreen,
      arguments: {
        "text": address,
        "lat": lat,
        "lng": lng,
      },
    );
    if (result != null) {
      debugPrint('result ==>${result.toString()}}');
      Map<String, dynamic> add = result as Map<String, dynamic>;
      if (add.isNotEmpty) {
        lat = result['lat'];
        lng = result['lng'];
        addressController.text = result['text'];
        setState(() {
          address = result['text'];
        });
      }
    }
  }
}
