import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/alert_dialogs/image_picker_alert_dialog.dart';
import 'package:value_client/widgets/index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // String address = '';
  File? image;
  late String countryValue = '';
  late String countryLabel = '';
  late String areaValue = '';
  late String areaLabel = '';
  late String cityValue = '';
  late String cityLabel = '';

  late List<dynamic> countries = [];
  late List<dynamic> areas = [];
  late List<dynamic> cities = [];
  String? countryId;

  showCountryPicker(BuildContext context, cubit) {
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
    Picker(
      selecteds: selectedIndex != -1 ? [selectedIndex] : [],
      adapter: PickerDataAdapter(data: countriesData),
      title: Text(AppLocalizations.of(context)!.country),
      cancelText: AppLocalizations.of(context)!.cancel,
      confirmText: AppLocalizations.of(context)!.confirm,
      onConfirm: (Picker picker, List value) {
        // cubit.getStates(picker.getSelectedValues()[0].toString());

        var selectedCountry = countries.firstWhere(
            (element) => element['id'] == picker.getSelectedValues()[0]);
        debugPrint('SELECTEDCOUNTRY: $selectedCountry}', wrapWidth: 1024);

        setState(
          () {
            countryLabel = selectedCountry['name'];
            countryValue = picker.getSelectedValues()[0].toString();
            countryId = picker.getSelectedValues()[0].toString();
            // areas = [];
            // cities = [];
            // areaValue = '';
            // areaLabel = '';
            // cityLabel = '';
            // cityValue = '';
          },
        );
      },
    ).showModal(context);
  }

  showAreaPicker(BuildContext context, cubit) {
    if (areas.isEmpty) {
      AppSnackBar.showError(
          context, AppLocalizations.of(context)!.there_is_no_states);
      return;
    }
    var areasData = areas
        .map((e) => PickerItem(text: Text(e['name']), value: e['id']))
        .toList();
    Picker(
      adapter: PickerDataAdapter(data: areasData),
      title: Text(AppLocalizations.of(context)!.area),
      cancelText: AppLocalizations.of(context)!.cancel,
      confirmText: AppLocalizations.of(context)!.confirm,
      onConfirm: (Picker picker, List value) {
        var selectedArea = areas.firstWhere(
            (element) => element['id'] == picker.getSelectedValues()[0]);
        setState(
          () {
            areaLabel = selectedArea['name'];
            areaValue = picker.getSelectedValues()[0].toString();
            cities = [];
            cityLabel = '';
            cityValue = '';
          },
        );
        // cubit.getCities(areaValue);
      },
    ).showModal(context);
  }

  showCityPicker(BuildContext context) {
    if (cities.isEmpty) {
      AppSnackBar.showError(
          context, AppLocalizations.of(context)!.there_is_no_cities);
      return;
    }
    var citiesData = cities
        .map((e) => PickerItem(text: Text(e['name']), value: e['id']))
        .toList();
    Picker(
      adapter: PickerDataAdapter(data: citiesData),
      title: Text(AppLocalizations.of(context)!.area),
      cancelText: AppLocalizations.of(context)!.cancel,
      confirmText: AppLocalizations.of(context)!.confirm,
      onConfirm: (Picker picker, List value) {
        var selectedCity = cities.firstWhere(
            (element) => element['id'] == picker.getSelectedValues()[0]);
        setState(
          () {
            cityLabel = selectedCity['name'];
            cityValue = picker.getSelectedValues()[0].toString();
          },
        );
      },
    ).showModal(context);
  }

  @override
  void initState() {
    AppCubit cubit = AppCubit.get(context);
    cubit.getCountries();
    super.initState();
    name.text = cubit.userData.user!.name == null
        ? ""
        : cubit.userData.user!.name as String;
    email.text = cubit.userData.user!.email == null
        ? ""
        : cubit.userData.user!.email as String;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (state is UpdateProfileErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is GetStatesErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is GetCitiesErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is UpdateProfileLoadedState) {
          AppSnackBar.showSuccess(
              context, AppLocalizations.of(context)!.profile_updated);

          // Navigator.of(context).pop();
        }
        if (state is GetCountriesLoadedState) {
          debugPrint('GetCountriesLoadedState 11111 $state');
          countries = state.data;
          countryId = cubit.userData.user!.country!['id'].toString();
          countryValue = cubit.userData.user!.country!['id'].toString();
          countryLabel = cubit.userData.user!.country!['name'];
          // setState(() {
          //   countryValue = cubit.userData.user!.country!['id'].toString();
          //   countryLabel = cubit.userData.user!.country!['name'];
          // });
          // if (cubit.countryId != '') {
          //   debugPrint('cubit.userData.user!.countryId: ${cubit.countryId}',
          //       wrapWidth: 1024);
          //   for (var item in state.data) {
          //     if (item['id'] == cubit.countryId) {
          //       debugPrint('xxxxxxxxxxxxx ${cubit.countryId} ${item['id']}');

          //     }
          //   }
          // }
        }
        if (state is GetCountriesErrorState) {
          debugPrint('GetCountriesErrorState $state');
          AppSnackBar.showError(context, state.error);
        }
        // if (state is GetStatesLoadedState) {
        //   setState(() {
        //     areas = state.data;
        //   });
        // }
        // if (state is GetCitiesLoadedState) {
        //   setState(() {
        //     cities = state.data;
        //   });
        // }
        // if (state is GetCountriesLoadedState) {
        // debugPrint('GetCountriesLoadedState $state');
        // countries = state.data;
        // areas = [];
        // cities = [];
        // if (cubit.userData.user!.city != null) {
        //   cubit.getStates(
        //       cubit.userData.user!.city!['state']['country']['id']);
        //   cubit.getCities(cubit.userData.user!.city!['state']['id']);
        //   debugPrint('hh =>${cubit.userData.user!.city!['id']}');

        //   areaLabel = cubit.userData.user!.city!['state']['name'] as String;
        //   countryLabel = cubit.userData.user!.city!['state']['country']
        //       ['name'] as String;
        //   cityLabel = cubit.userData.user!.city!['name'] as String;
        // }
        // }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        // debugPrint('user in profle ${cubit.userData.user.toString()}');

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.profile),
          ),
          body: NetworkSensitive(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        AppImages.backgroundwhite,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              InkWell(
                                onTap: () => showImagePicerDialog(),
                                child: Container(
                                  width: 130,
                                  height: 120,
                                  // padding: EdgeInsets.all(1),
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      // color: AppColors.primaryL,
                                      // borderRadius: BorderRadius.circular(15)
                                      ),
                                  child: image != null
                                      ? ClipRRect(
                                          // borderRadius: BorderRadius.circular(15),
                                          child: Image.file(
                                            image!,
                                            // fit: BoxFit.cover,
                                          ),
                                        )
                                      : cubit.userData.user!.image != null
                                          ? ClipRRect(
                                              // borderRadius:
                                              //     BorderRadius.circular(15),
                                              child: Image.network(
                                                cubit.userData.user!.image
                                                    as String,
                                                // fit: BoxFit.cover,
                                                // width: 80,
                                                // height: 80,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child:
                                                  Image.asset(AppImages.logo),
                                            ),
                                ),
                              ),
                              Positioned(
                                left: 0.0,
                                bottom: 0.0,
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: AppColors.gray,
                                  child: IconButton(
                                    icon: const Icon(
                                      AppIcons.write,
                                      size: 13,
                                    ),
                                    onPressed: () => showImagePicerDialog(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: cubit.isRTL(context)
                                            ? Matrix4.rotationY(math.pi)
                                            : Matrix4.rotationY(math.pi * 2),
                                        child: const Icon(
                                          AppIcons.telephone,
                                          color: AppColors.primaryL,
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.phoneNumber,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(AppRoutes.changePhoneScreen),
                                  // iconSize: 35,
                                  icon: const Icon(
                                    AppIcons.write,
                                    color: AppColors.accentL,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      AppIcons.key,
                                      color: AppColors.primaryDark,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.password,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(
                                          AppRoutes.changePasswordScreen),
                                  // iconSize: 35,
                                  icon: const Icon(
                                    AppIcons.write,
                                    color: AppColors.accentL,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            controller: name,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.name,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            // TOFO fix name validation .. can be null or must be greater than or = 3
                            validator: (value) {
                              if (value!.isValidName || value.isEmpty) {
                                return null;
                              } else {
                                return AppLocalizations.of(context)!
                                    .please_enter_valid_name;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: email,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.email,
                              prefixIcon: const Icon(
                                AppIcons.mail,
                                color: AppColors.primaryDark,
                                size: 16,
                              ),
                            ),
                            // TOFO fix email validation .. can be null or must be valid email

                            validator: (value) {
                              if (value!.isValidEmail || value.isEmpty) {
                                return null;
                              } else {
                                return AppLocalizations.of(context)!
                                    .please_enter_valid_email;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              if (state is GetCountriesLoadingState) return;
                              showCountryPicker(context, cubit);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        AppIcons.flag,
                                        color: AppColors.primaryDark,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      state is GetCountriesLoadingState
                                          ? const AppLoading(
                                              scale: .5,
                                              color: AppColors.primaryL,
                                            )
                                          : Text(
                                              countryLabel != ''
                                                  ? countryLabel
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .country,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.primaryDark,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          // InkWell(
                          //   onTap: () {
                          //     if (state is GetStatesLoadingState) return;
                          //     showAreaPicker(context, cubit);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(vertical: 10),
                          //     decoration: BoxDecoration(
                          //         color: AppColors.white,
                          //         borderRadius: BorderRadius.circular(30)),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: <Widget>[
                          //         Row(
                          //           children: <Widget>[
                          //             SizedBox(
                          //               width: 10,
                          //             ),
                          //             Icon(
                          //               AppIcons.select,
                          //               color: AppColors.primaryDark,
                          //             ),
                          //             SizedBox(
                          //               width: 10,
                          //             ),
                          //             state is GetStatesLoadingState
                          //                 ? AppLoading(
                          //                     scale: .5,
                          //                     color: AppColors.primaryL,
                          //                   )
                          //                 : Text(
                          //                     areaLabel != ''
                          //                         ? areaLabel
                          //                         : AppLocalizations.of(context)!
                          //                             .area,
                          //                     style: TextStyle(fontSize: 16),
                          //                   )
                          //           ],
                          //         ),
                          //         Padding(
                          //           padding: EdgeInsets.symmetric(horizontal: 10),
                          //           child: Icon(
                          //             Icons.keyboard_arrow_down,
                          //             color: AppColors.primaryDark,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 20),
                          // InkWell(
                          //   onTap: () {
                          //     if (state is GetStatesLoadingState) return;
                          //     showCityPicker(context);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(vertical: 10),
                          //     decoration: BoxDecoration(
                          //         color: AppColors.white,
                          //         borderRadius: BorderRadius.circular(30)),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: <Widget>[
                          //         Row(
                          //           children: <Widget>[
                          //             SizedBox(
                          //               width: 10,
                          //             ),
                          //             Icon(
                          //               AppIcons.office_building,
                          //               color: AppColors.primaryDark,
                          //             ),
                          //             SizedBox(
                          //               width: 10,
                          //             ),
                          //             state is GetCitiesLoadingState
                          //                 ? AppLoading(
                          //                     scale: .5,
                          //                     color: AppColors.primaryL,
                          //                   )
                          //                 : Text(
                          //                     cityLabel != ''
                          //                         ? cityLabel
                          //                         : AppLocalizations.of(context)!
                          //                             .city,
                          //                     style: TextStyle(fontSize: 16),
                          //                   ),
                          //           ],
                          //         ),
                          //         Padding(
                          //           padding: EdgeInsets.symmetric(horizontal: 10),
                          //           child: Icon(
                          //             Icons.keyboard_arrow_down,
                          //             color: AppColors.primaryDark,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 20),
                          AppButton(
                            loading: state is UpdateProfileLoadingState,
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                String fileName = image != null
                                    ? image!.path.split('/').last
                                    : "";

                                debugPrint('hh => 2 =>$cityValue');
                                cubit.updateProfile(
                                  {
                                    "name": name.text,
                                    "email": email.text,
                                    "country_id": countryId,
                                    "city_id": cityValue,
                                    "image": image != null
                                        ? await MultipartFile.fromFile(
                                            image!.path,
                                            filename: fileName)
                                        : ""
                                  },
                                );
                              }
                            },
                            title: AppLocalizations.of(context)!.update,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showImagePicerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialogBox(
          onPickImage: (image) {
            debugPrint('IMAGE 222222 2222 : $image}', wrapWidth: 1024);
            setState(() {
              this.image = image;
            });
            // Navigator.pop(context, 'Ok');
          },
        );
      },
    );
  }
}
