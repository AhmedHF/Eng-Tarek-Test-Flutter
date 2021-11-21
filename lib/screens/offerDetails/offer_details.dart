import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/screens/my_value/cubit/my_values_cubit.dart';
import 'package:value_client/widgets/app_conditional_widget.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';
import 'package:value_client/widgets/offer_actions.dart';
import 'package:value_client/widgets/offer_details_info.dart';

class OfferDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    debugPrint('arguments==>${arguments['id'].toString()}');
    return BlocProvider(
        create: (context) =>
            MyValuesCubit()..getMyValueDetails(arguments['id'].toString()),
        child: Scaffold(
          appBar:
              AppBar(title: Text(AppLocalizations.of(context)!.offer_details)),
          body: NetworkSensitive(
            child: Stack(children: <Widget>[
              Image.asset(
                AppImages.background,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              BlocBuilder<MyValuesCubit, MyValuesState>(
                  builder: (context, state) {
                return AppConditionalBuilder(
                    loadingCondition: state is MyValueDetailsLoadingState,
                    loadingColor: AppColors.white,
                    emptyCondition: state is MyValueDetailsSuccessState &&
                        state.myValueDetails.isEmpty,
                    errorCondition: state is MyValueDetailsErrorState,
                    errorMessage:
                        state is MyValueDetailsErrorState ? state.error : '',
                    successCondition: state is MyValueDetailsSuccessState,
                    successBuilder: (context) =>
                        state is MyValueDetailsSuccessState
                            ? SingleChildScrollView(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OfferActions(
                                      data: state.myValueDetails,
                                    ),
                                    OfferDetailsInfo(data: state.myValueDetails)
                                  ],
                                ),
                              )
                            : Container());
              })
            ]),
          ),
        ));
  }
}
