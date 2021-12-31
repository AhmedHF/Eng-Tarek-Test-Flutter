import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/screens/offerDetails/cubit/fav_cubit.dart';
import 'package:value_client/screens/purchased_coupon/cubit/gift_cubit.dart';
import 'package:value_client/screens/search/cubit/search_cubit.dart';
import 'package:value_client/screens/storesList/cubit/stores_slider_cubit.dart';
import 'core/utils/connection/cubit/connection_cubit.dart';
import 'core/utils/network/cubit/internet_cubit.dart';
import 'core/services/navigation_service.dart';
import 'screens/cart/cubit/cart_cubit.dart';
import 'screens/home/cubit/home_cubit.dart';
import 'screens/home/cubit/slider_cubit.dart';
import 'screens/home/cubit/top_discount_cubit.dart';
import 'screens/home/cubit/top_offers_cubit.dart';
import 'screens/my_value/cubit/saving_cubit.dart';
import 'screens/rated_offers/cubit/rated_offers_cubit.dart';
import 'package:value_client/injection_container.dart' as di;

class ValueClient extends StatelessWidget {
  final String initialRoute;
  const ValueClient({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.serviceLocator<ConnectionCheckerCubit>()),
        // BlocProvider<ConnectionCheckerCubit>(
        //   create: (_) => ConnectionCheckerCubit(
        //       internetConnectionChecker: InternetConnectionChecker()),
        // ),
        BlocProvider<InternetCubit>(
          create: (_) => InternetCubit(connectivity: Connectivity()),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) {
            AppCubit cubit = AppCubit.get(context);
            return HomeCubit()..getTopStores(cubit.countryId);
          },
        ),
        BlocProvider(
          create: (context) => SliderCubit()..getSlider(),
        ),
        BlocProvider(
          create: (context) {
            AppCubit cubit = AppCubit.get(context);
            return TopDiscountCubit()..getTopDiscount(cubit.countryId);
          },
        ),
        BlocProvider(
          create: (context) {
            AppCubit cubit = AppCubit.get(context);
            return TopOffersCubit()..getTopRatedOffers(cubit.countryId);
          },
        ),
        BlocProvider(
          create: (context) => RatedOffersCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => GiftCubit(),
        ),
        BlocProvider(
          create: (context) => StoresSliderCubit()..getSlider(),
        ),
        BlocProvider(
          create: (context) => FavCubit(),
        ),
        BlocProvider(
          create: (context) => SavingCubit(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Value',
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            locale: state.locale,
            initialRoute: initialRoute,
            onGenerateRoute: AppRouter.onGenerateAppRoute,
          );
        },
      ),
    );
  }
}
