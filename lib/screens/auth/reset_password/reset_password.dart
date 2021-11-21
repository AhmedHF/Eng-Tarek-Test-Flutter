import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  bool _obscureText = true;
  bool _obscureTextConfirm = true;
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

  @override
  Widget build(BuildContext context) {
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ResetPasswordErrorState) {
          AppSnackBar.showError(context, state.error);
        }
        if (state is ResetPasswordLoadedState) {
          AppSnackBar.showSuccess(context, AppLocalizations.of(context)!.done);

          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Image.asset(
                './assets/images/background.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              NetworkSensitive(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 150, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              AppLocalizations.of(context)!.reset_the_password,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 28),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .to_reset_your_password_please_enter_new_password,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 40),
                        child: Form(
                          key: _form,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: _obscureText,
                                controller: password,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .new_password,
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
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  errorStyle: const TextStyle(
                                    color: AppColors.accentL,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                cursorColor: AppColors.primaryL,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .required;
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: _obscureTextConfirm,
                                controller: confirmpassword,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .confirm_password,
                                  filled: true,
                                  fillColor: AppColors.white,
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  errorStyle: const TextStyle(
                                    color: AppColors.accentL,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                focusNode: _passwordFocusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .required;
                                  } else if (!value.isValidPassword) {
                                    return AppLocalizations.of(context)!
                                        .password_validations;
                                  } else if (!value.isValidMinLength(8)) {
                                    return AppLocalizations.of(context)!
                                        .at_least_7_char;
                                  } else if (!value.isValidMaxLength(15)) {
                                    return AppLocalizations.of(context)!
                                        .at_most_15_char;
                                  } else if (password.text !=
                                      confirmpassword.text) {
                                    return AppLocalizations.of(context)!
                                        .password_not_match;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppButton(
                        width: 320,
                        loading: state is ResetPasswordLoadingState,
                        title: AppLocalizations.of(context)!.continue_btn,
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            if (state is ResetPasswordLoadingState) return;
                            cubit.resetPassword({
                              "new_password": password.text,
                              "new_password_confirmation": confirmpassword.text,
                              "phone": arguments[0],
                              "code": arguments[1],
                              "country_id": arguments[2],
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 25),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.loginScreen, (route) => false);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.already_have_account,
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
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.termsScreen);
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
                                color: AppColors.white,
                                fontWeight: FontWeight.w400),
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
          ),
        );
      },
    );
  }
}
