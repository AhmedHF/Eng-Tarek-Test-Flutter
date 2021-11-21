import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/storeDetails/cubit/store_cubit.dart';
import 'package:value_client/screens/storeDetails/store_discount.dart';
import 'package:value_client/screens/storeDetails/store_info.dart';
import 'package:value_client/screens/storeDetails/store_offers.dart';
import 'package:value_client/screens/storeDetails/store_update.dart';
import 'package:value_client/widgets/app_conditional_widget.dart';
import 'package:value_client/widgets/app_swiper.dart';
import 'package:value_client/widgets/branch_list_btn.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({Key? key}) : super(key: key);

  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // debugPrint('arguments==>${arguments['id'].toString()}');
    return BlocProvider(
      create: (context) =>
          StoreCubit()..getStoreDetails(arguments['id'].toString()),
      child: Scaffold(
        appBar: AppBar(title: Text(arguments['name'])),
        body: NetworkSensitive(
          child: Stack(
            children: <Widget>[
              Image.asset(
                AppImages.background,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  if (state is StoreDetailsSuccessState) {
                    debugPrint(
                        'STATE00000000 00000 : ${state.storeDetails['working_from']}',
                        wrapWidth: 1024);
                  }
                  return AppConditionalBuilder(
                    loadingCondition: state is StoreDetailsLoadingState,
                    loadingColor: AppColors.white,
                    emptyCondition: state is StoreDetailsSuccessState &&
                        state.storeDetails.isEmpty,
                    errorCondition: state is StoreDetailsErrorState,
                    errorMessage:
                        state is StoreDetailsErrorState ? state.error : '',
                    successCondition: state is StoreDetailsSuccessState,
                    successBuilder: (context) => state
                            is StoreDetailsSuccessState
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                // Container(
                                //   child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    state.storeDetails['images'].length > 0
                                        ? Container(
                                            height: 190,
                                            color: AppColors.primaryL,
                                            child: sliderData(
                                              context,
                                              state.storeDetails['images'],
                                            ),
                                          )
                                        : Container(),
                                    Container(
                                      // child: Positioned(
                                      //   left: 20,
                                      //   bottom: 50,
                                      margin: EdgeInsets.only(
                                          top: state.storeDetails['images']
                                                      .length >
                                                  0
                                              ? 110
                                              : 10,
                                          left: 20,
                                          right: 20),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundGrey,
                                        radius: 25,
                                        child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Image.network(
                                              state.storeDetails['image'],
                                              height: 25,
                                              width: 25,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      // ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: state.storeDetails['images']
                                                      .length >
                                                  0
                                              ? 170
                                              : 90,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: <Widget>[
                                          StoreInfo(state.storeDetails),
                                          StoreUpdate(state.storeDetails),
                                          state.storeDetails['discount'] !=
                                                      null &&
                                                  state
                                                          .storeDetails[
                                                              'discount']
                                                              ['memberships']
                                                          .length >
                                                      0
                                              ? StoreDiscount(
                                                  state.storeDetails)
                                              : Container(),
                                          state.storeDetails['coupons'].length >
                                                  0
                                              ? StoreOffers(
                                                  state.storeDetails['coupons'])
                                              : Container(),
                                          BranchListBtn(
                                            AppColors.white,
                                            AppRoutes.searchBranchListScreen,
                                            state.storeDetails['working_from'],
                                            state.storeDetails['working_to'],
                                            state
                                                .storeDetails['store_branches'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sliderData(context, data) {
    List<SliderModel> slider = [];
    data.forEach((item) {
      slider.add(SliderModel(
        id: item['id'],
        image: item['image'],
      ));
    });
    return Container(
        width: double.infinity,
        height: data.isEmpty ? 0 : 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppSwiper(
          slider: slider,
        ));
  }
}
