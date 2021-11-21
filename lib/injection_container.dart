import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'navigation_service.dart';

GetIt serviceLocator = GetIt.asNewInstance();

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => AppLocalizations);
  serviceLocator.registerLazySingleton(() => NavigationService());
  debugPrint('################################');
}
