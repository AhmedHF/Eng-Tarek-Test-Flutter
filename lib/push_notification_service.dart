import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

Future<void> initializePushNotificationService(context) async {
  initializeFirebaseService();
  AwesomeNotifications().actionStream.listen((notification) {
    if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
      AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
          );
    }
    debugPrint('notification ===== ----: $notification}', wrapWidth: 1024);
    Navigator.of(context).pushNamed(
      AppRoutes.notificationsScreen,
    );
  });

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      isAllowed = await requestPermissionToSendNotifications(context);
    }
  });
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> initializeFirebaseService() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String firebaseAppToken = await messaging.getToken(
        // https://stackoverflow.com/questions/54996206/firebase-cloud-messaging-where-to-find-public-vapid-key
        vapidKey: '',
      ) ??
      '';

  print('Firebase token: $firebaseAppToken');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('==> Got a message whilst in the foreground!');
    debugPrint('==> Message : $message}');
    debugPrint('==> Message data: ${message.data}');

    if (
        // This step (if condition) is only necessary if you pretend to use the
        // test page inside console.firebase.google.com
        !StringUtils.isNullOrEmpty(message.notification?.title,
                considerWhiteSpaceAsEmpty: true) ||
            !StringUtils.isNullOrEmpty(message.notification?.body,
                considerWhiteSpaceAsEmpty: true)) {
      print('Message also contained a notification: ${message.notification}');

      String? imageUrl;
      imageUrl ??= message.notification!.android?.imageUrl;
      imageUrl ??= message.notification!.apple?.imageUrl;

      // https://pub.dev/packages/awesome_notifications#notification-types-values-and-defaults
      Map<String, dynamic> notificationAdapter = {
        NOTIFICATION_CONTENT: {
          NOTIFICATION_ID: Random().nextInt(2147483647),
          NOTIFICATION_CHANNEL_KEY: 'basic_channel',
          NOTIFICATION_TITLE: message.notification!.title,
          NOTIFICATION_BODY: message.notification!.body,
          NOTIFICATION_LAYOUT:
              StringUtils.isNullOrEmpty(imageUrl) ? 'Default' : 'BigPicture',
          NOTIFICATION_BIG_PICTURE: imageUrl
        }
      };

      AwesomeNotifications()
          .createNotificationFromJsonData(notificationAdapter);
    } else {
      AwesomeNotifications().createNotificationFromJsonData(message.data);
    }
  });
}

Future<bool> requestPermissionToSendNotifications(BuildContext context) async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xfffbfbfb),
              title: const Text('Get Notified!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/animated-bell.gif',
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ),
                  const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Later',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    )),
                TextButton(
                  onPressed: () async {
                    isAllowed = await AwesomeNotifications()
                        .requestPermissionToSendNotifications();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }
  return isAllowed;
}
