import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  int selectedCountry = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NetworkSensitive(
        child: Stack(
          children: <Widget>[
            Image.asset(
              AppImages.background,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                AppCubit cubit = AppCubit.get(context);
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        width: double.infinity,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 25),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: AppList(
                            loadingColor: AppColors.white,
                            loadingListItems: state is GetCountriesLoadingState,
                            hasReachedEndOfResults:
                                state is GetCountriesLoadedState,
                            endLoadingFirstTime:
                                state is GetCountriesLoadedState,
                            listItems: cubit.countries,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCountry =
                                      cubit.countries[index]['id'];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: selectedCountry ==
                                            cubit.countries[index]['id']
                                        ? AppColors.red
                                        : AppColors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: selectedCountry ==
                                            cubit.countries[index]['id']
                                        ? 12
                                        : 10,
                                  ),
                                  child: Text(
                                    cubit.countries[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            fetchPageData: (query) => cubit.getCountries(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      AppButton(
                        title: AppLocalizations.of(context)!.continue_btn,
                        onPressed: () async {
                          if (selectedCountry != -1) {
                            await cubit
                                .setCountryId(selectedCountry.toString());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.appHome, (route) => false);
                          } else {
                            AppSnackBar.showInfo(
                                context,
                                AppLocalizations.of(context)!
                                    .you_must_choose_country);
                          }
                        },
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
