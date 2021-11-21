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

class VerifyUpdateMobile extends StatefulWidget {
  const VerifyUpdateMobile({Key? key}) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyUpdateMobile> {
  bool isVerified = false;
  String currentText = '';
  String code = '';

  @override
  Widget build(BuildContext context) {
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        if (state is ResendErrorState) {
          debugPrint('resend state  ERROR=====${state.error}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(
                  state.error,
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.red),
          );
        }
        if (state is ResendLoadedState) {
          debugPrint('state=====${state.data}');
          setState(() {
            code = state.data['code'];
            // counter++;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(
                  state.data['message'],
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.green),
          );
        }
        if (state is UpdateMobileVerifyErrorState) {
          debugPrint('state ERROR=====${state.error}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(
                  state.error,
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.red),
          );
        }
        if (state is UpdateMobileVerifyUserLoadedState) {
          AppSnackBar.showSuccess(
              context, AppLocalizations.of(context)!.phone_updated);

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
          String initLanguage = LanguageRepository.initLanguage();
          DioHelper.init(
              lang: initLanguage, token: state.verifyData.token as String);

          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.appHome, (route) => false);
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
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              arguments[0] as String,
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
                                  color: AppColors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      // form here
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
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
                              fieldOuterPadding: const EdgeInsets.all(10),
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
                              setState(() {
                                isVerified = true;
                                currentText = v;
                              });
                            },
                            onChanged: (value) {
                              // setState(() {
                              //   currentText = value;
                              // });
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                      ),
                      // todo remove code after test
                      const SizedBox(height: 15),
                      Text(
                        code != '' ? code : ' ${arguments[1]}',
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        AppLocalizations.of(context)!.did_not_receive_the_code,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          if (state is ResendLoadingState) return;
                          cubit.resendCode({
                            "phone": arguments[2].user.phone,
                            'country_id': arguments[3],
                          });
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
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (state is UpdateMobileVerifyLoadingState) return;
                            if (isVerified) {
                              cubit.updateMobileVerify({
                                "code": currentText,
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('enter code'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.accentL),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: state is UpdateMobileVerifyLoadingState
                              ? const AppLoading(
                                  scale: 0.5,
                                )
                              : Text(
                                  AppLocalizations.of(context)!.next_btn,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
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
