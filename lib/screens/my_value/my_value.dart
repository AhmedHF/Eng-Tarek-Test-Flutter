import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/core/utils/utils.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/my_value/cubit/my_values_cubit.dart';
import 'package:value_client/widgets/clippers/value_image_clipper.dart';
import 'package:value_client/widgets/index.dart';
import 'package:value_client/widgets/weird_border.dart';

import 'cubit/saving_cubit.dart';
import 'cubit/user_membership_cubit.dart';

class MyValueScreen extends StatelessWidget {
  const MyValueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    if (cubit.userData.user == null) {
      return WillPopScope(
          onWillPop: () async {
            cubit.onItemTapped(0);
            return false;
          },
          child: const NoUserWidget());
    } else {
      return WillPopScope(
        onWillPop: () async {
          Scaffold.of(context).openEndDrawer();
          cubit.onItemTapped(0);
          return false;
        },
        child: NetworkSensitive(
          child: BlocProvider(
            create: (context) => MyValuesCubit(),
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  header(context),
                  filterSection(context),
                  myValuesList(context),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget header(context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        right: 10,
        left: 10,
      ),
      child: ClipPath(
        clipper: ValueImageClipper(),
        child: SizedBox(
          width: double.infinity,
          height: 90,
          child: Stack(
            children: [
              Image.asset(
                AppImages.myValue,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                color: AppColors.clip.withOpacity(0.7),
              ),
              BlocProvider(
                create: (context) =>
                    UserMembershipCubit()..getUserMemberShipDetails(),
                child: BlocConsumer<UserMembershipCubit, UserMembershipState>(
                  listener: (context, state) {
                    SavingCubit cubit = SavingCubit.get(context);
                    if (state is UserMemberShipSuccessState) {
                      cubit.getSaving();
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is UserMemberShipLoadingState)
                                const AppLoading(
                                  scale: 0.5,
                                ),
                              if (state is UserMemberShipErrorState)
                                AppError(error: state.error),
                              if (state is UserMemberShipSuccessState)
                                Text.rich(
                                  TextSpan(
                                    text: state.userMemberShip['membership']
                                                    ['name']
                                                .toString()
                                                .split(' ')
                                                .length >
                                            1
                                        ? state.userMemberShip['membership']
                                                ['name']
                                            .toString()
                                            .split(' ')[0]
                                        : state.userMemberShip['membership']
                                                ['name']
                                            .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ), // default text style
                                    children: <TextSpan>[
                                      if (state.userMemberShip['membership']
                                                  ['name']
                                              .toString()
                                              .split(' ')
                                              .length >
                                          1)
                                        TextSpan(
                                          text: " " +
                                              state.userMemberShip['membership']
                                                      ['name']
                                                  .toString()
                                                  .split(' ')[1],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.yellow,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        lineBuilder(),
                        Expanded(
                          child: BlocBuilder<SavingCubit, SavingState>(
                            builder: (context, state) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'you saved',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (state is SavingLoadingState)
                                    const AppLoading(
                                      scale: 0.5,
                                    ),
                                  if (state is SavingSuccessState)
                                    Text(
                                      state.saving.toString(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        if (state is UserMemberShipSuccessState) lineBuilder(),
                        if (state is UserMemberShipSuccessState)
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      AppRoutes.qrScreen,
                                      arguments: {
                                        'id': state.userMemberShip['id'],
                                        'name':
                                            state.userMemberShip['membership']
                                                ['name'],
                                        'date':
                                            state.userMemberShip['created_at'],
                                      }),
                                  child: Image.asset(
                                    AppImages.qr,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterSection(context) {
    return BlocBuilder<MyValuesCubit, MyValuesState>(
      builder: (context, state) {
        MyValuesCubit cubit = MyValuesCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipPath(
            clipper: FullTicketClipper(10, 65),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DottedBorder(
                  color: AppColors.gray,
                  strokeWidth: 1,
                  dashPattern: const [5],
                  customPath: (size) {
                    return Path()
                      ..moveTo(0, size.height)
                      ..lineTo(size.width, size.height);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          final result = await Navigator.of(context)
                              .pushNamed(AppRoutes.couponTypeScreen);
                          cubit.getMyValues({'coupon_type_id': result});
                        },
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.couponType,
                              style: const TextStyle(
                                color: AppColors.grayText,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(
                              Icons.filter_alt_outlined,
                              color: AppColors.grayText,
                            )
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            final result = await Navigator.of(context)
                                .pushNamed(AppRoutes.categoryScreen);
                            cubit.getMyValues({'category_id': result});
                          },
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.category,
                                style: const TextStyle(
                                  color: AppColors.grayText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.filter_alt_outlined,
                                color: AppColors.grayText,
                              )
                            ],
                          )),
                      TextButton(
                        onPressed: () async {
                          final result = await Navigator.of(context).pushNamed(
                            AppRoutes.myValueSortByScreen,
                          ) as SortByDateType;
                          if (result == SortByDateType.purchased) {
                            cubit.getMyValues({'buy_date': 'desc'});
                          } else if (result == SortByDateType.expired) {
                            cubit.getMyValues({'expire_date': 'desc'});
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.sort_by,
                              style: const TextStyle(
                                color: AppColors.grayText,
                                fontSize: 15,
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget myValuesList(context) {
    return BlocBuilder<MyValuesCubit, MyValuesState>(
      builder: (context, state) {
        MyValuesCubit cubit = MyValuesCubit.get(context);
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: ShapeDecoration(
              shape: WeirdBorder(
                radius: 10,
                pathWidth: 1000,
              ),
              color: AppColors.white,
            ),
            child: AppList(
              key: const Key('MyValues List'),
              fetchPageData: (query) => cubit.getMyValues(query),
              loadingListItems: state is MyValuesLoadingState,
              hasReachedEndOfResults: cubit.hasReachedEndOfResults,
              endLoadingFirstTime: cubit.endLoadingFirstTime,
              itemBuilder: (context, index) => ValueItem(
                item: cubit.myValues[index],
                onPress: () => Navigator.of(context).pushNamed(
                    AppRoutes.purchasedCouponScreen,
                    arguments: {'id': cubit.myValues[index].id}),
              ),
              listItems: cubit.myValues,
            ),
            // child: AppConditionalBuilder(
            //   loadingCondition: state is MyValuesLoadingState,
            //   emptyCondition:
            //       state is MyValuesSuccessState && state.myValues.isEmpty,
            //   errorCondition: state is MyValuesErrorState,
            //   errorMessage: state is MyValuesErrorState ? state.error : '',
            //   successCondition: state is MyValuesSuccessState,
            //   successBuilder: (context) => state is MyValuesSuccessState
            //       ? ListView.separated(
            //           physics: BouncingScrollPhysics(),
            //           itemBuilder: (context, index) => ValueItem(
            //             item: state.myValues[index],
            //             onPress: () => Navigator.of(context)
            //                 .pushNamed(AppRoutes.purchasedCouponScreen),
            //           ),
            //           separatorBuilder: separatorBuilder,
            //           itemCount: state.myValues.length,
            //         )
            //       : Container(),
            // ),
          ),
        );
      },
    );
  }

  Widget lineBuilder() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: double.infinity,
      width: 1,
      child: Image.asset(
        AppImages.line,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
