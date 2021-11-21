import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:value_client/widgets/app_snack_bar.dart';
import 'package:value_client/widgets/index.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _obscureText = true;
  bool _obscureTextOld = true;
  bool _obscureTextConfirm = true;

  final TextEditingController password = TextEditingController();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  String address = '';
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleOld() {
    setState(() {
      _obscureTextOld = !_obscureTextOld;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ChangePasswordErrorState) {
          debugPrint('state ERROR=====${state.error}');
          AppSnackBar.showError(context, state.error);
        }
        if (state is ChangePasswordLoadedState) {
          debugPrint('state=====$state');
          AppSnackBar.showSuccess(context, state.data);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: NetworkSensitive(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Stack(children: <Widget>[
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureTextOld,
                          controller: oldPassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.old_password,
                            prefixIcon: const Icon(
                              AppIcons.key,
                              color: AppColors.primaryL,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureTextOld
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryL,
                              ),
                              onPressed: _toggleOld,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
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
                          obscureText: _obscureText,
                          controller: password,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.new_password,
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
                          ),
                          // The validator receives the text that the user has entered.
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
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                        const SizedBox(height: 30),
                        AppButton(
                          loading: state is ChangePasswordLoadingState,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.changePassword({
                                "old_password": oldPassword.text,
                                "new_password": password.text,
                                "new_password_confirmation":
                                    confirmpassword.text,
                              });
                            }
                          },
                          title: AppLocalizations.of(context)!.save,
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
