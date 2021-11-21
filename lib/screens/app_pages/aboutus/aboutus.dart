import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/screens/app_pages/index.dart';
import 'package:value_client/widgets/index.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppPagesCubit()..getAboutUs(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.about_us),
        ),
        backgroundColor: AppColors.backgroundGrey,
        body: NetworkSensitive(
          child: BlocBuilder<AppPagesCubit, AppPagesState>(
            builder: (context, state) {
              if (state is AboutUsLoadingState) {
                return const AppLoading(
                  color: AppColors.primaryL,
                );
              }
              if (state is AboutUsSuccessState) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Html(
                    data: state.aboutUs.value,
                  ),
                );
              }
              if (state is AboutUsErrorState) {
                return AppError(
                  error: state.error,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
