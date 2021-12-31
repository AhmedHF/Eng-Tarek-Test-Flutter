import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:value_client/core/services/navigation_service.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> initDynamicLinks() async {
  FirebaseDynamicLinks.instance.onLink(
    onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      debugPrint('DEEPLINK onLink : $deepLink}', wrapWidth: 1024);

      if (deepLink != null) {
        if (deepLink.toString().contains('/coupon-details/')) {
          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .pushNamed(
            AppRoutes.offerDetailsScreen,
            arguments: {'id': deepLink.path.split('/')[2]},
          );
        }
      }
    },
    onError: (OnLinkErrorException e) async {
      debugPrint('onLinkError');
      debugPrint(e.message);
    },
  );

  final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deepLink = data?.link;
  debugPrint('DEEPLINK getInitialLink : $deepLink}', wrapWidth: 1024);

  if (deepLink != null) {
    if (deepLink.toString().contains('/coupon-details/')) {
      Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
        AppRoutes.offerDetailsScreen,
        arguments: {'id': deepLink.path.split('/')[2]},
      );
    }
  }
}

Future<void> createDynamicLink(bool short, link) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://allvalueclub.page.link',
    link: Uri.parse(link),
    androidParameters: AndroidParameters(
      packageName: 'com.value.client',
      minimumVersion: 0,
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
    // iosParameters: IosParameters(
    //   bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
    //   minimumVersion: '0',
    // ),
  );

  Uri url;
  if (short) {
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;
  } else {
    url = await parameters.buildUrl();
  }

  Share.share(
      '${AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!.share_message} \n\n$url');
}

// open link as url . for launching a URL
void openURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
