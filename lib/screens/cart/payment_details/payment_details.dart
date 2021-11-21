import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/widgets/index.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: const BackButton(
          color: AppColors.black,
        ),
        title: Text(
          '${arguments['title']}',
          style: const TextStyle(color: AppColors.black, fontSize: 18),
        ),
        actions: [
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(color: AppColors.accentL, fontSize: 16),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: NetworkSensitive(
        child: Stack(
          children: <Widget>[
            Image.asset(
              AppImages.backgroundwhite,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DottedBorder(
                    color: AppColors.gray,
                    strokeWidth: 1,
                    dashPattern: const [5],
                    customPath: (size) {
                      return Path()
                        ..moveTo(0, size.height)
                        ..lineTo(size.width, size.height);
                    },
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        priceItem(
                          context,
                          AppLocalizations.of(context)!.subtotal,
                          arguments['totalPrice'],
                        ),
                        const SizedBox(height: 10),
                        priceItem(
                          context,
                          AppLocalizations.of(context)!.sales_tax,
                          arguments['tax'],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  priceItem(
                    context,
                    AppLocalizations.of(context)!.pay_target,
                    arguments['finalPrice'],
                    bold: true,
                  ),
                  const SizedBox(height: 100),
                  paymentButton(
                    context,
                    arguments['paymentMethod'],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget priceItem(context, title, price, {bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: bold ? FontWeight.bold : null,
            fontSize: 18,
          ),
        ),
        Text(
          "$price ${AppLocalizations.of(context)!.sar}",
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: bold ? FontWeight.bold : null,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget paymentButton(context, paymentId) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CheckoutSuccessState) {
          Navigator.of(context).pushNamed(
            AppRoutes.paymentWebViewScreen,
            arguments: {'url': state.data['payment_url']},
          );
        }
        if (state is CheckoutErrorState) {
          AppSnackBar.showError(context, state.error);
        }
      },
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return AppButton(
          title: AppLocalizations.of(context)!.payment,
          width: 200,
          loading: state is CheckoutLoadingState,
          onPressed: () {
            cubit.checkout(paymentId);
          },
        );
      },
    );
  }
}
