import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/dynamic_links_service.dart';
import 'package:value_client/push_notification_service.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/home/cubit/home_cubit.dart';
import 'package:value_client/screens/home/cubit/slider_cubit.dart';
import 'package:value_client/screens/home/cubit/top_discount_cubit.dart';
import 'package:value_client/screens/home/cubit/top_offers_cubit.dart';
import 'package:value_client/screens/home/item_header.dart';
import 'package:value_client/widgets/index.dart';
import 'package:value_client/components/index.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initializePushNotificationService(context);
    initDynamicLinks();

    /// =================================================================
    debugPrint('get data  +++===============');
    AppCubit cubit = AppCubit.get(context);
    SliderCubit sliderCubit = SliderCubit.get(context);
    sliderCubit.getSlider();
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getTopStores(cubit.countryId);
    TopDiscountCubit cubitTopDiscount = TopDiscountCubit.get(context);
    cubitTopDiscount.getTopDiscount(cubit.countryId);
    TopOffersCubit cubitTopOffers = TopOffersCubit.get(context);
    cubitTopOffers.getTopRatedOffers(cubit.countryId);
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Scaffold.of(context).openEndDrawer();
        exit(0);
        // return false;
      },
      child: Scaffold(
        body: NetworkSensitive(
          child: RefreshIndicator(
            backgroundColor: AppColors.white,
            color: AppColors.primaryL,
            onRefresh: refreshData,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, right: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // search(context),
                    sliderData(context),
                    topStoresList(context),
                    topDiscountList(context),
                    topratedOffersList(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    debugPrint('refresh data +++===============');
    AppCubit cubit = AppCubit.get(context);
    await Future.delayed(const Duration(milliseconds: 2000));
    SliderCubit sliderCubit = SliderCubit.get(context);
    sliderCubit.getSlider();
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getTopStores(cubit.countryId);
    TopDiscountCubit cubitTopDiscount = TopDiscountCubit.get(context);
    cubitTopDiscount.getTopDiscount(cubit.countryId);
    TopOffersCubit cubitTopOffers = TopOffersCubit.get(context);
    cubitTopOffers.getTopRatedOffers(cubit.countryId);
  }

  Widget search(context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.find_your_store,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.new_discount_especially,
          style: Theme.of(context).textTheme.headline3,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.of(context).pushNamed(AppRoutes.searchScreen);
            },
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.search,
              filled: true,
              fillColor: AppColors.input,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.white,
              ),
              // prefix: Icon(
              //   Icons.search,
              //   color: AppColors.white,
              // ),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              labelStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget sliderData(context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: state is SliderSuccessState && state.slider.isEmpty ? 0 : 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: AppConditionalBuilder(
            loadingColor: AppColors.white,
            loadingCondition: state is SliderLoadingState,
            emptyCondition: state is SliderSuccessState && state.slider.isEmpty,
            errorCondition: state is SliderErrorState,
            errorMessage: state is SliderErrorState ? state.error : '',
            successCondition: state is SliderSuccessState,
            successBuilder: (context) => state is SliderSuccessState
                ? AppSwiper(
                    slider: state.slider,
                  )
                : Container(),
          ),
        );
      },
    );
  }

  Widget topStoresList(context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(
            // left: 10,
            // right: 10,
            top: 10,
          ),
          decoration: ShapeDecoration(
            shape: WeirdBorder(
              radius: 10,
              pathWidth: 1000,
            ),
            color: AppColors.white,
          ),
          child: DottedBorder(
            color: AppColors.gray,
            strokeWidth: 2.5,
            dashPattern: const [5],
            customPath: (size) {
              return Path()
                ..moveTo(20, size.height)
                ..lineTo(size.width - 20, size.height);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  ItemHeader(
                    title: AppLocalizations.of(context)!.top_store,
                    onPress: () => Navigator.of(context)
                        .pushNamed(AppRoutes.storesListScreen),
                  ),
                  Container(
                    height: 90.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AppConditionalBuilder(
                      loadingCondition: state is TopStoresLoadingState,
                      emptyCondition: state is TopStoresSuccessState &&
                          state.topStores.isEmpty,
                      errorCondition: state is TopStoresErrorState,
                      errorMessage:
                          state is TopStoresErrorState ? state.error : '',
                      successCondition: state is TopStoresSuccessState,
                      successBuilder: (context) =>
                          state is TopStoresSuccessState
                              ? ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      StoreItem(item: state.topStores[index]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 5,
                                  ),
                                  itemCount: state.topStores.length,
                                )
                              : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget topDiscountList(context) {
    return BlocBuilder<TopDiscountCubit, TopDiscountState>(
      builder: (context, state) {
        return Container(
          decoration: ShapeDecoration(
            shape: WeirdBorder(
              radius: 10,
              pathWidth: 1000,
            ),
            color: AppColors.white,
          ),
          child: DottedBorder(
            color: AppColors.gray,
            strokeWidth: 2.5,
            dashPattern: const [5],
            customPath: (size) {
              return Path()
                ..moveTo(20, size.height)
                ..lineTo(size.width - 20, size.height);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  ItemHeader(
                    title: AppLocalizations.of(context)!.top_discount,
                    viewAll: false,
                  ),
                  Container(
                    height: 200.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AppConditionalBuilder(
                      loadingCondition: state is TopDiscountLoadingState,
                      emptyCondition: state is TopDiscountSuccessState &&
                          state.topDiscount.isEmpty,
                      errorCondition: state is TopDiscountErrorState,
                      errorMessage:
                          state is TopDiscountErrorState ? state.error : '',
                      successCondition: state is TopDiscountSuccessState,
                      successBuilder: (context) =>
                          state is TopDiscountSuccessState
                              ? ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => DiscountItem(
                                    item: state.topDiscount[index],
                                    index: index,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 10,
                                  ),
                                  itemCount: state.topDiscount.length,
                                )
                              : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget topratedOffersList(context) {
    return BlocBuilder<TopOffersCubit, TopOffersState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: ShapeDecoration(
            shape: WeirdBorder(
              radius: 10,
              pathWidth: 1000,
            ),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              ItemHeader(
                title: AppLocalizations.of(context)!.top_rated_offers,
                onPress: () => Navigator.of(context)
                    .pushNamed(AppRoutes.ratedOffersScreen),
              ),
              AppConditionalBuilder(
                loadingCondition: state is TopRatedOffersLoadingState,
                emptyCondition: state is TopRatedOffersSuccessState &&
                    state.topRatedOffers.isEmpty,
                errorCondition: state is TopRatedOffersErrorState,
                errorMessage:
                    state is TopRatedOffersErrorState ? state.error : '',
                successCondition: state is TopRatedOffersSuccessState,
                successBuilder: (context) => state is TopRatedOffersSuccessState
                    ? ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ValueItem(
                            item: state.topRatedOffers[index],
                            onPress: () => Navigator.of(context).pushNamed(
                                    AppRoutes.offerDetailsScreen,
                                    arguments: {
                                      'id': state.topRatedOffers[index].id
                                    })),
                        separatorBuilder: separatorBuilder,
                        itemCount: state.topRatedOffers.length,
                      )
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
