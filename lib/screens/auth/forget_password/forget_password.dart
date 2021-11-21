import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/widgets/app_button.dart';

import 'package:value_client/widgets/index.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();

  String countryCode = '+966';
  String? countryId;
  late List<dynamic> countries = [];

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
        if (state is ForgetPasswordErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is ForgetPasswordLoadedState) {
          debugPrint('state=====$state');

          AppSnackBar.showSuccess(context, state.data['message']);
          Navigator.of(context).pushNamed(
            AppRoutes.verifyCodeScreen,
            arguments: [
              AppLocalizations.of(context)!.verify_phone_number,
              AppRoutes.resetPasswordScreen,
              phone.text,
              state.data['code'],
              "",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   AppLocalizations.of(context)!.change_phone_hint,
                        //   style: Theme.of(context).textTheme.headline1,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            AppLocalizations.of(context)!.forget_password,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 28),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            AppLocalizations.of(context)!
                                .to_reset_your_password_please_enter_mobile,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),

                        const SizedBox(height: 50),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            autofillHints: const [
                              AutofillHints.telephoneNumberNational
                            ],
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

                        const SizedBox(height: 30),

                        AppButton(
                          loading: state is ForgetPasswordLoadingState,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (state is ForgetPasswordLoadingState) return;
                              cubit.forgetPassword({
                                "phone": phone.text,
                                "country_id": countryId,
                              });
                            }
                          },
                          title: AppLocalizations.of(context)!.next,
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
}
