import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/extensions/hex_colors.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/models/check_box.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/screens/storesList/cubit/stores_cubit.dart';
import 'package:value_client/screens/storesList/cubit/stores_slider_cubit.dart';
import 'package:value_client/widgets/app_conditional_widget.dart';
import 'package:value_client/widgets/app_list.dart';
import 'package:value_client/widgets/app_swiper.dart';
import 'package:value_client/widgets/categories.dart';
import 'package:value_client/widgets/network/network_sensitive.dart';
import 'package:value_client/widgets/store_card.dart';
import 'package:value_client/widgets/weird_border.dart';

class StoresListScreen extends StatefulWidget {
  const StoresListScreen({Key? key}) : super(key: key);

  @override
  _StoresListScreenState createState() => _StoresListScreenState();
}

class _StoresListScreenState extends State<StoresListScreen> {
  var selectedCategory = CheckBoxModal(id: -1, title: '', count: '');
  @override
  void initState() {
    super.initState();
    // SliderCubit cubit = SliderCubit.get(context);
    // cubit.getSlider();
  }

  void _onSelect(v, context) {
    setState(() {
      selectedCategory = v;
    });
    StoresCubit storesCubit = StoresCubit.get(context);
    AppCubit appCubit = AppCubit.get(context);
    storesCubit.getStores({
      "catId": selectedCategory.id == -1 ? '' : selectedCategory.id,
      'country_id': appCubit.countryId,
    });
  }

  Future refreshData() async {
    debugPrint('refresh data +++===============');
    await Future.delayed(const Duration(milliseconds: 2000));
    StoresSliderCubit cubit = StoresSliderCubit.get(context);
    cubit.getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoresCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(selectedCategory.id == -1
              ? AppLocalizations.of(context)!.stores_list
              : selectedCategory.title.toString()),
        ),
        body: NetworkSensitive(
          child: RefreshIndicator(
            backgroundColor: AppColors.white,
            color: AppColors.primaryL,
            onRefresh: refreshData,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  AppImages.background,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 190,
                      child: sliderData(context),
                    ),
                    BlocBuilder<StoresCubit, StoresState>(
                      builder: (context, state) {
                        return Container(
                          decoration: ShapeDecoration(
                            shape: WeirdBorder(radius: 10, pathWidth: 1000),
                            color: AppColors.backgroundLightGray,
                          ),
                          margin: const EdgeInsets.only(
                              bottom: 1, top: 5, left: 10, right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 20),
                              Categories((v) => _onSelect(v, context),
                                  selectedCategory, const Key('categories')),
                              const SizedBox(height: 10),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius:
                              //           BorderRadius.circular(20)),
                              //   child: Image.asset(
                              //     AppImages.slide2,
                              //     width: double.infinity,
                              //     height: 130,
                              //     fit: BoxFit.fill,
                              //   ),
                              // ),
                              // SizedBox(height: 15),
                              buildCategoryStores(selectedCategory, context)
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderData(context) {
    return BlocBuilder<StoresSliderCubit, StoresSliderState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height:
              state is StoresSliderSuccessState && state.storesSlider.isEmpty
                  ? 0
                  : 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: AppConditionalBuilder(
            loadingColor: AppColors.white,
            loadingCondition: state is StoresSliderLoadingState,
            emptyCondition:
                state is StoresSliderSuccessState && state.storesSlider.isEmpty,
            errorCondition: state is StoresSliderErrorState,
            errorMessage: state is StoresSliderErrorState ? state.error : '',
            successCondition: state is StoresSliderSuccessState,
            successBuilder: (context) => state is StoresSliderSuccessState
                ? AppSwiper(
                    slider: state.storesSlider,
                  )
                : Container(),
          ),
        );
      },
    );
  }

  Widget buildCategoryStores(category, context) {
    return BlocBuilder<StoresCubit, StoresState>(builder: (context, state) {
      StoresCubit cubit = StoresCubit.get(context);
      AppCubit appCubit = AppCubit.get(context);

      return AppList(
        key: const Key('Stores List'),
        fetchPageData: (query) {
          Map<String, dynamic> queryTemp = {};
          queryTemp.addAll(query);
          queryTemp.addAll({
            'country_id': appCubit.countryId,
          });
          return cubit.getStores(queryTemp);
        },
        emptyBuilder: (context) => SizedBox(
          height: 200,
          child: Center(
            child: Text(AppLocalizations.of(context)!.no_data),
          ),
        ),
        loadingListItems: state is StoresLoadingState,
        hasReachedEndOfResults: cubit.hasReachedEndOfResults,
        endLoadingFirstTime: cubit.endLoadingFirstTime,
        itemBuilder: (context, index) => StoreCard(
          id: cubit.stores[index]['id'].toString(),
          name: cubit.stores[index]['name'] as String,
          image: cubit.stores[index]['image'] as String,
          upTo: cubit.stores[index]['up_to'].toString(),
          value: cubit.stores[index]['coupons_number'].toString(),
          featured: cubit.stores[index]['featured'],
          categoryColor: category.id == -1
              ? AppColors.primaryL
              : HexColor.fromHex(category.color),
        ),
        listItems: cubit.stores,
      );
    });
  }
}
