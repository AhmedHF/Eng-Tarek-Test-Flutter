import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/core/utils/enum/enum.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/components/my_value_item/value_item.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/rated_offers/cubit/rated_offers_cubit.dart';
import 'package:value_client/widgets/index.dart';

class RatedOffersScreen extends StatelessWidget {
  const RatedOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatedOffersCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.top_rated_offers),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.search),
          //   ),
          // ],
        ),
        body: NetworkSensitive(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipPath(
              clipper: FullTicketClipper(10, 65),
              child: Container(
                height: MediaQuery.of(context).size.height - 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: DottedBorder(
                  color: AppColors.gray,
                  strokeWidth: 1,
                  dashPattern: const [4],
                  customPath: (size) {
                    return Path()
                      ..moveTo(5, 65)
                      ..lineTo(size.width - 5, 65);
                  },
                  child: Column(
                    children: [
                      sortWidget(context),
                      ratedOffersList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sortWidget(context) {
    return BlocBuilder<RatedOffersCubit, RatedOffersState>(
      builder: (context, state) {
        RatedOffersCubit cubit = RatedOffersCubit.get(context);

        return Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Text(
                  AppLocalizations.of(context)!.offers,
                  style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final result = await Navigator.of(context).pushNamed(
                    AppRoutes.sortByScreen,
                  ) as SortType;
                  if (result == SortType.top) {
                    cubit.getRatedOffers({'rate': 'desc'});
                  } else if (result == SortType.low) {
                    cubit.getRatedOffers({'top': 'asc'});
                  } else if (result == SortType.high) {
                    cubit.getRatedOffers({'top': 'desc'});
                  }
                },
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sort_by,
                      style: const TextStyle(
                        color: AppColors.grayText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.grayText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget ratedOffersList() {
    return BlocBuilder<RatedOffersCubit, RatedOffersState>(
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        RatedOffersCubit cubit = RatedOffersCubit.get(context);
        return Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AppList(
              loadingListItems: state is RatedOffersLoadingState,
              hasReachedEndOfResults: cubit.hasReachedEndOfResults,
              endLoadingFirstTime: cubit.endLoadingFirstTime,
              listItems: cubit.ratedOffers,
              itemBuilder: (context, index) => ValueItem(
                item: cubit.ratedOffers[index],
                onPress: () => Navigator.of(context).pushNamed(
                  AppRoutes.offerDetailsScreen,
                  arguments: {'id': cubit.ratedOffers[index].id},
                ),
              ),
              fetchPageData: (query) => cubit.getRatedOffers(
                {
                  'top': 'desc',
                  'rate': 'desc',
                  'country_id': appCubit.countryId,
                  ...query,
                },
              ),
            ),
            // child: AppConditionalBuilder(
            //   loadingCondition: state is RatedOffersLoadingState,
            //   emptyCondition: state is RatedOffersSuccessState &&
            //       state.ratedOffers.isEmpty,
            //   errorCondition: state is RatedOffersErrorState,
            //   errorMessage: state is RatedOffersErrorState ? state.error : '',
            //   successCondition: state is RatedOffersSuccessState,
            //   successBuilder: (context) => state is RatedOffersSuccessState
            //       ? ListView.separated(
            //           physics: BouncingScrollPhysics(),
            //           itemBuilder: (context, index) => ValueItem(
            //               item: state.ratedOffers[index],
            //               onPress: () => Navigator.of(context).pushNamed(
            //                   AppRoutes.offerDetailsScreen,
            //                   arguments: {'id': state.ratedOffers[index].id})),
            //           separatorBuilder: separatorBuilder,
            //           itemCount: state.ratedOffers.length,
            //         )
            //       : Container(),
            // ),
          ),
        );
      },
    );
  }
}
