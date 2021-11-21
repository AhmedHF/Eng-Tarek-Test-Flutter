import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/utils/utils.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/widgets/index.dart';
import 'package:value_client/widgets/weird_border.dart';

import 'checkout_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late String _title;
  int paymentId = -1;

  @override
  void initState() {
    super.initState();
    CartCubit cubit = CartCubit.get(context);
    cubit.getCartItems();
    cubit.getCartTotalPrice();
    cubit.getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.checkout),
      ),
      body: NetworkSensitive(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  CartCubit cubit = CartCubit.get(context);
                  if (state is CartTotalPriceLoadingState) {
                    return const AppLoading();
                  } else {
                    return ClipPath(
                      clipper: FullTicketClipper(
                          10, (cubit.cartItems.length * 125) + 80),
                      child: Container(
                        height: (cubit.cartItems.length * 125) + 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DottedBorder(
                            color: AppColors.gray,
                            strokeWidth: 2,
                            dashPattern: const [5],
                            customPath: (size) {
                              return Path()
                                ..moveTo(10, size.height)
                                ..lineTo(size.width, size.height);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                cartList(),
                                const SizedBox(
                                  height: 20,
                                ),
                                totalPrice(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              paymentDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartList() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              CheckoutCard(item: cubit.cartItems[index]),
          itemCount: cubit.cartItems.length,
        );
      },
    );
  }

  Widget totalPrice() {
    CartCubit cubit = CartCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.total_amount,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          '${cubit.totalPrice['total_without_tax']} ${AppLocalizations.of(context)!.sar}',
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget paymentDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      decoration: ShapeDecoration(
        shape: WeirdBorder(
          radius: 10,
          pathWidth: 1000,
        ),
        color: AppColors.white,
      ),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is PaymentMethodsSuccessState) {
            setState(() {
              paymentId = state.paymentMethods[0]['id'];
              _title = state.paymentMethods[0]['name'];
            });
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.payment_details,
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppConditionalBuilder(
                loadingColor: AppColors.primaryL,
                loadingCondition: state is PaymentMethodsLoadingState,
                emptyCondition: state is PaymentMethodsSuccessState &&
                    state.paymentMethods.isEmpty,
                errorCondition: state is PaymentMethodsErrorState,
                errorMessage:
                    state is PaymentMethodsErrorState ? state.error : '',
                successCondition: state is PaymentMethodsSuccessState,
                successBuilder: (context) => state is PaymentMethodsSuccessState
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => paymentItem(
                          state.paymentMethods[index],
                        ),
                        itemCount: state.paymentMethods.length,
                      )
                    : Container(),
              ),
              paymentButton(),
            ],
          );
        },
      ),
    );
  }

  Widget paymentItem(item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(item['name']),
        trailing: Radio<int>(
          value: item['id'],
          groupValue: paymentId,
          onChanged: (int? value) {
            setState(() {
              _title = item['name'];
              paymentId = value!;
            });
          },
        ),
        leading: AppImage(
          imageURL: item['image'],
          width: 50,
          height: 40,
        ),
      ),
    );
  }

  Widget paymentButton() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      child: AppButton(
        title: AppLocalizations.of(context)!.payment,
        width: 200,
        onPressed: () {
          CartCubit cubit = CartCubit.get(context);
          Navigator.of(context).pushNamed(
            AppRoutes.paymentDetailsScreen,
            arguments: {
              'finalPrice': cubit.totalPrice['total'],
              'tax': cubit.totalPrice['tax'],
              'totalPrice': cubit.totalPrice['total_without_tax'],
              'paymentMethod': paymentId,
              'title': _title,
            },
          );
        },
      ),
    );
  }
}
