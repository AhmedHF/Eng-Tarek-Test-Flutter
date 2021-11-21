import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/styles/icons.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool secure;
  final IconData? suffixIcon;
  final String? Function(String?)? validations;

  const AppInput({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.textInputAction,
    this.secure = false,
    this.suffixIcon,
    this.validations,
  }) : super(key: key);

  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    bool _obscureText = widget.secure;

    // void _toggle() {
    //   debugPrint('dddddddd print ');
    //   setState(() {
    //     _obscureText = false;
    //   });
    // }

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      controller: widget.controller,
      textInputAction: widget.textInputAction != null
          ? widget.textInputAction
          : TextInputAction.done,
      // decoration: InputDecoration(
      //   border: const OutlineInputBorder(),
      //   filled: true,
      //   hintText: 'Your Password',
      //   labelText: 'Password',
      //   prefixIcon: Icon(
      //     Icons.lock,
      //   ),
      //   suffixIcon: IconButton(
      //     icon: Icon(
      //       _obscureText ? Icons.visibility : Icons.visibility_off,
      //     ),
      //     onPressed: _toggle,
      //   ),
      // ),
      decoration: InputDecoration(
        // labelText: AppLocalizations.of(context)!.phoneNumber,
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: Icon(
          AppIcons.telephone,
          color: AppColors.primaryL,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelStyle: TextStyle(color: Colors.grey),
      ),
      cursorColor: AppColors.primaryL,
      // The validator receives the text that the user has entered.
      validator: widget.validations,
    );
  }
}
