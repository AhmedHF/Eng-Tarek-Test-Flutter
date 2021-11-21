import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({Key? key}) : super(key: key);

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.payment),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return NetworkSensitive(
            child: Stack(
              children: [
                WebView(
                  initialUrl: arguments['url'],
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    debugPrint("WebView is loading (progress : $progress%)");
                  },
                  onPageStarted: (String url) {
                    setState(() {
                      isLoading = true;
                    });
                    debugPrint('Page started loading: $url');
                  },
                  onPageFinished: (String url) async {
                    debugPrint('Page finished loading: $url');
                    if (url.contains('/payment-success')) {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      AppCubit cubit = AppCubit.get(context);
                      cubit.onItemTapped(0);
                      Navigator.of(context)
                          .pushNamed(AppRoutes.orderCreatedScreen);
                    }
                    if (url.contains('/payment-error')) {
                      await Future.delayed(const Duration(milliseconds: 2000));
                      Navigator.of(context).pop();
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  gestureNavigationEnabled: true,
                ),
                if (isLoading)
                  const AppLoading(
                    color: AppColors.primaryL,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
