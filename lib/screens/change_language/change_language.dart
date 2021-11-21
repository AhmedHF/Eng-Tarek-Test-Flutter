import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/core/helpers/dio_helper.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/repositories/language.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String selectedLanguage = 'ar';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppCubit cubit = AppCubit.get(context);
    selectedLanguage = cubit.getCurrentLanguage(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(color: AppColors.black),
            ),
            backgroundColor: AppColors.bg,
            leading: const BackButton(color: AppColors.black),
          ),
          backgroundColor: AppColors.backgroundLightGray,
          body: NetworkSensitive(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  AppImages.backgroundwhite,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        AppLocalizations.of(context)!.switch_between_languages,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListTile(
                        title: const Text('English'),
                        trailing: Radio<String>(
                          value: 'en',
                          groupValue: selectedLanguage,
                          onChanged: (String? value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('العربية'),
                        trailing: Radio<String>(
                          value: 'ar',
                          groupValue: selectedLanguage,
                          onChanged: (String? value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 50),
                      AppButton(
                        title: AppLocalizations.of(context)!.done,
                        onPressed: () {
                          debugPrint(
                              '=========================================');
                          print(cubit.isRTL(context));

                          DioHelper.init(
                              lang: selectedLanguage,
                              token: cubit.userData.user != null
                                  ? cubit.userData.token.toString()
                                  : '');
                          cubit.setLang(Locale(selectedLanguage));
                          LanguageRepository.setLangData(selectedLanguage);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
