import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/services/navigation_service.dart';
import 'core/utils/connection/cubit/connection_cubit.dart';

GetIt serviceLocator = GetIt.asNewInstance();

Future<void> init() async {
  // Bloc
  serviceLocator.registerFactory<ConnectionCheckerCubit>(() =>
      ConnectionCheckerCubit(internetConnectionChecker: serviceLocator.call()));

  serviceLocator.registerLazySingleton(() => AppLocalizations);
  serviceLocator.registerLazySingleton(() => NavigationService());

  //External
  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  serviceLocator.registerLazySingleton(() => internetConnectionChecker);
  debugPrint('################################');
}
