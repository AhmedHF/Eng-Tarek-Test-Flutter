import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:value_client/widgets/app_snack_bar.dart';

import 'package:value_client/widgets/index.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({Key? key}) : super(key: key);

  @override
  _ChangePhoneScreenState createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();

  String countryCode = '';
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
    final selectedIndex =
        countries.indexWhere((e) => e['id'].toString() == countryId);
    debugPrint('SELECTED: $selectedIndex}', wrapWidth: 1024);
    Picker(
      selecteds: selectedIndex != -1 ? [selectedIndex] : [],
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
    phone.text = cubit.userData.user!.phone.toString();
    countryCode = cubit.userData.user!.country!['code'];
    countryId = cubit.userData.user!.country!['id'].toString();
    cubit.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        debugPrint('CUBIT ##### : ${cubit.userData.user!.country!['id']}',
            wrapWidth: 1024);
        if (state is GetCountriesLoadedState && countryId == null) {
          // countries = state.data;
          // countries.forEach((item) {
          //   if (cubit.userData.user!.country!['id'] == item['id']) {
          //     countryCode = item['code'];
          //     countryId = item['id'].toString();
          //   }
          // });
        }
        if (state is UpdateMobileErrorState) {
          debugPrint('state ERROR=====${state.error}');
          AppSnackBar.showError(context, state.error);
        }
        if (state is UpdateMobileLoadedState) {
          debugPrint('state=====${state.data.toString()}');

          Navigator.of(context).pushNamed(
            AppRoutes.verifyUpdateMobile,
            arguments: [
              AppLocalizations.of(context)!.verify_phone_number,
              state.data.user!.verificationCode,
              state.data,
              countryId
            ],
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.change_phone),
          ),
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
                        // Text(
                        //   AppLocalizations.of(context)!.change_phone_hint,
                        //   style: Theme.of(context).textTheme.headline1,
                        // ),

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
                                child:
                                    //  state is GetCountriesLoadingState
                                    //     ? const AppLoading(
                                    //         color: AppColors.primaryL,
                                    //         scale: 0.4,
                                    //       )
                                    //     :
                                    GestureDetector(
                                  onTap: () {
                                    // showCountryPicker(context);
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
                          loading: state is UpdateMobileLoadingState,
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              if (cubit.userData.user!.phone == phone.text) {
                                AppSnackBar.showError(
                                    context,
                                    AppLocalizations.of(context)!
                                        .you_already_use_this_phone_number);
                              } else {
                                cubit.updateMobile({
                                  "phone": phone.text,
                                  'country_id': countryId,
                                });
                              }
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
