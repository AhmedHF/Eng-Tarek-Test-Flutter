import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/core/extensions/extensions.dart';
import 'package:value_client/models/complain_type.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/screens/contact_us/cubit/contact_us_cubit.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:value_client/widgets/app_snack_bar.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _dropdownState = GlobalKey<FormFieldState>();

    final TextEditingController message = TextEditingController();
    final TextEditingController customerName = TextEditingController();
    final TextEditingController customerEmail = TextEditingController();
    final TextEditingController phoneNumber = TextEditingController();

    final TextEditingController storeName = TextEditingController();

    return BlocProvider(
      create: (context) => ContactUsCubit(),
      child: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          if (state is ContactUsErrorState) {
            AppSnackBar.showError(context, state.error);
          }
          if (state is ContactUsSuccessState) {
            AppSnackBar.showSuccess(context, state.message);
            // _formKey.currentState!.reset();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          ContactUsCubit cubit = ContactUsCubit.get(context);

          return Scaffold(
            // resizeToAvoidBottomInset: true,
            appBar:
                AppBar(title: Text(AppLocalizations.of(context)!.contact_us)),
            body: NetworkSensitive(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownButtonFormField<ComplainTypeModel>(
                          key: _dropdownState,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: getComplainTypes(context)
                              .map(buildMenuItem)
                              .toList(),
                          value: cubit.complainType,
                          dropdownColor: AppColors.white,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.gray,
                            size: 25,
                          ),
                          hint: Text(
                            AppLocalizations.of(context)!.choose,
                            style: const TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                          onChanged: (newVal) {
                            cubit.setSelectedComplainType(newVal!);
                          },
                          validator: (value) {
                            if (value != null) {
                              return null;
                            } else {
                              return AppLocalizations.of(context)!.required;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          maxLines: 6,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          controller: message,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.primaryL, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            hintText: AppLocalizations.of(context)!.message,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            } else if (!value.isValidMinLength(4)) {
                              return AppLocalizations.of(context)!
                                  .at_least_4_char_f;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          controller: storeName,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            hintText: AppLocalizations.of(context)!.store_name,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            } else if (!value.isValidMinLength(4)) {
                              return AppLocalizations.of(context)!
                                  .at_least_4_char;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          controller: customerName,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            hintText:
                                AppLocalizations.of(context)!.customer_name,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            } else if (!value.isValidMinLength(4)) {
                              return AppLocalizations.of(context)!
                                  .at_least_4_char;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          controller: customerEmail,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            hintText: AppLocalizations.of(context)!.email,
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            } else if (value.isValidEmail) {
                              return null;
                            } else {
                              return AppLocalizations.of(context)!
                                  .please_enter_valid_email;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.gray, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            hintText: AppLocalizations.of(context)!.phoneNumber,
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
                        const SizedBox(height: 30),
                        AppButton(
                          loading: state is ContactUsLoadingState,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              // Navigator.of(context).pushNamed(AppRoutes.appHome);
                              cubit.sendContactUs({
                                'name': customerName.text,
                                'email': customerEmail.text,
                                'title': storeName.text,
                                'message': message.text,
                                'mobile': phoneNumber.text,
                                'type': cubit.complainType!.id,
                              });
                            }
                          },
                          title: AppLocalizations.of(context)!.send,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  DropdownMenuItem<ComplainTypeModel> buildMenuItem(ComplainTypeModel item) =>
      DropdownMenuItem(
        value: item,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            DottedBorder(
              color: AppColors.gray,
              strokeWidth: 1,
              // radius: Radius.circular(5),
              dashPattern: const [5],
              customPath: (size) {
                return Path()
                  ..moveTo(0, size.height)
                  ..lineTo(size.width, size.height);
              },
              child: Container(),
            ),
          ],
        ),
      );

  List<ComplainTypeModel> getComplainTypes(BuildContext context) {
    final items = [
      ComplainTypeModel(
        id: '0',
        value: 'order',
        label: AppLocalizations.of(context)!.order,
      ),
      ComplainTypeModel(
        id: '1',
        value: 'complaint',
        label: AppLocalizations.of(context)!.complaint,
      ),
      ComplainTypeModel(
        id: '2',
        value: 'suggestion',
        label: AppLocalizations.of(context)!.suggestion,
      ),
      ComplainTypeModel(
        id: '3',
        value: 'notes',
        label: AppLocalizations.of(context)!.notes,
      ),
    ];

    return items;
  }
}
