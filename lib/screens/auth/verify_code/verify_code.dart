import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool isVerified = false;
  String currentText = '';
  String code = '';
  // int counter = 0;
  bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        if (state is ResendErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is ResendLoadedState) {
          AppSnackBar.showSuccess(context, state.data['message']);
          setState(() {
            code = state.data['code'];
            // counter++;
          });
        }
        if (state is VerifyErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is VerifyLoadedState) {
          debugPrint('state222=====${state.verifyData.toString()}');
          AppSnackBar.showSuccess(context, state.verifyData['message']);
          Navigator.of(context).pushNamed(
            arguments.length > 1 ? arguments[1] : AppRoutes.verifiedScreen,
            arguments: arguments.length > 1
                ? [arguments[2], code != '' ? code : arguments[3], arguments[5]]
                : [],
          );
        }
        if (state is VerifyUserLoadedState) {
          debugPrint('state=====${state.verifyData.user.toString()}');
          debugPrint('is verifiedScreen${arguments[1]}');

          if (arguments[1] == '/verified') {
            String initLanguage = LanguageRepository.initLanguage();
            DioHelper.init(
                lang: initLanguage, token: state.verifyData.token as String);

            cubit.setUser(UserDataModel(
                user: state.verifyData.user, token: state.verifyData.token));
            StorageHelper.saveObject(
              key: 'userdata',
              object: UserDataModel(
                token: state.verifyData.token,
                user: UserModel(
                  id: state.verifyData.user!.id,
                  name: state.verifyData.user!.name,
                  email: state.verifyData.user!.email,
                  phone: state.verifyData.user!.phone,
                  image: state.verifyData.user!.image,
                  lat: state.verifyData.user!.lat,
                  lng: state.verifyData.user!.lng,
                  verificationCode: state.verifyData.user!.verificationCode,
                  isActive: state.verifyData.user!.isActive,
                  verified: state.verifyData.user!.verified,
                  country: state.verifyData.user!.country,
                ),
              ),
            );
          }
          Navigator.of(context).pushNamed(
            arguments.length > 1 ? arguments[1] : AppRoutes.verifiedScreen,
            arguments: arguments.length > 1
                ? [arguments[2], code != '' ? code : arguments[3]]
                : [],
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Container(),
          ),
          body: NetworkSensitive(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  AppImages.bgverify,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              arguments.isNotEmpty
                                  ? arguments[0] as String
                                  : AppLocalizations.of(context)!
                                      .verify_account,
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 28),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              AppLocalizations.of(context)!.enter_code,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      // form here
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            length: 4,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            cursorColor: AppColors.primaryL,
                            keyboardType: TextInputType.number,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              borderWidth: 0,
                              fieldHeight: 120,
                              fieldOuterPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 5,
                              ),
                              fieldWidth: 55,
                              activeFillColor: AppColors.white,
                              inactiveColor: AppColors.white,
                              disabledColor: AppColors.white,
                              selectedFillColor: AppColors.white,
                              selectedColor: AppColors.white,
                              errorBorderColor: AppColors.white,
                              activeColor: AppColors.white,
                              inactiveFillColor: AppColors.white,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 200),
                            backgroundColor: Colors.transparent,
                            textStyle: const TextStyle(color: AppColors.black),
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            // controller: textEditingController,
                            onCompleted: (v) {
                              if (isNumeric(v)) {
                                setState(() {
                                  isVerified = true;
                                  currentText = v;
                                });
                              } else {
                                setState(() {
                                  isVerified = false;
                                  currentText = v;
                                });
                              }
                            },
                            onChanged: (value) {
                              debugPrint('value ===>> $value}');

                              // setState(() {
                              //   currentText = value;
                              // });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.required;
                              } else if (isNumeric(value)) {
                                return null;
                              } else {
                                return AppLocalizations.of(context)!
                                    .enter_valid_number;
                              }
                            },
                            appContext: context,
                          ),
                        ),
                      ),
                      // todo remove code after test
                      const SizedBox(height: 15),
                      Text(
                        code != '' ? code : ' ${arguments[3]}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        AppLocalizations.of(context)!.did_not_receive_the_code,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          if (state is ResendLoadingState) return;
                          cubit.resendCode(
                            {
                              "phone": arguments[2],
                              "country_id": arguments[5],
                            },
                          );
                        },
                        child: state is ResendLoadingState
                            ? const AppLoading()
                            : Text(
                                AppLocalizations.of(context)!.resend_code,
                                style: const TextStyle(
                                  color: AppColors.accentL,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                      ),
                      // SizedBox(height: 10),
                      // Text(
                      //   "$counter/3",
                      //   style: TextStyle(color: AppColors.white),
                      // ),
                      const SizedBox(height: 30),
                      AppButton(
                        width: 300,
                        loading: state is VerifyLoadingState,
                        title: AppLocalizations.of(context)!.next_btn,
                        onPressed: () {
                          debugPrint('isVerified$isVerified}');
                          debugPrint('currentText$currentText}');

                          if (state is VerifyLoadingState) return;
                          if (isVerified) {
                            cubit.verifyCode({
                              "phone": arguments[2],
                              "code": currentText,
                              "country_id": arguments[5],
                            }, arguments[4]);
                          } else if (currentText == '') {
                            AppSnackBar.showError(context,
                                AppLocalizations.of(context)!.enter_the_code);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
