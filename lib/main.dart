import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:value_client/core/helpers/dio_helper.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/injection_container.dart' as di;
import 'package:value_client/models/index.dart';
import 'package:value_client/my_app.dart';
import 'package:value_client/repositories/language.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';

import 'bloc_observer.dart';

/// Define a top-level named handler which background/terminated messages will call.
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // create notification channnel to handle notifications
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: AppColors.primaryL,
        ledColor: AppColors.secondaryL,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
      ),
    ],
  );

  // Create the initialization for your desired push service here
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await di.init();
  await StorageHelper.init();
  String initLanguage = LanguageRepository.initLanguage();
  debugPrint('initLanguage $initLanguage');
  String initialRoute = AppRoutes.loginScreen;
  String token = '';

  if (StorageHelper.getObject(key: 'userdata') != false) {
    UserDataModel userData =
        UserDataModel.fromJson(StorageHelper.getObject(key: 'userdata'));
    debugPrint('userData==> ${userData.user.toString()}');
    debugPrint('token==> ${userData.token.toString()}');

    if (userData.toJson().isNotEmpty &&
        userData.user!.isActive! &&
        userData.user!.verified!) {
      initialRoute = AppRoutes.appHome;
      token = userData.token as String;
    }
  }
  DioHelper.init(lang: initLanguage, token: token);
  Bloc.observer = MyBlocObserver();
  runApp(
    MyApp(
      initialRoute: initialRoute,
    ),
  );
}
