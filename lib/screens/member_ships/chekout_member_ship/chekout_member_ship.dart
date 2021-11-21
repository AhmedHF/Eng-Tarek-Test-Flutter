import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/screens/member_ships/cubit/membership_cubit.dart';
import 'package:value_client/widgets/index.dart';

class CheckoutMemberShipScreen extends StatefulWidget {
  const CheckoutMemberShipScreen({Key? key}) : super(key: key);

  @override
  _CheckoutMemberShipScreenState createState() =>
      _CheckoutMemberShipScreenState();
}

class _CheckoutMemberShipScreenState extends State<CheckoutMemberShipScreen> {
  int paymentId = -1;

  @override
  void initState() {
    super.initState();
    CartCubit cubit = CartCubit.get(context);
    cubit.getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    final memberShipPackage =
        ModalRoute.of(context)!.settings.arguments as MemberShipModel;
    debugPrint('passing arguments =========== > $memberShipPackage');

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.checkout)),
      body: NetworkSensitive(
        child: Stack(
          children: <Widget>[
            Image.asset(
              AppImages.background,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipPath(
                    clipper: FullTicketClipper(10, 180),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DottedBorder(
                          color: AppColors.gray,
                          strokeWidth: 2,
                          // radius: Radius.circular(5),
                          dashPattern: const [5],
                          customPath: (size) {
                            return Path()
                              ..moveTo(0, size.height)
                              ..lineTo(size.width, size.height);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                memberShipPackage.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      memberShipPackage.description,
                                    ),
                                  ),
                                  Text(
                                    "${memberShipPackage.price} ${AppLocalizations.of(context)!.sar}",
                                    style: const TextStyle(
                                        color: AppColors.primaryDark,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DottedBorder(
                                color: AppColors.gray,
                                strokeWidth: 1,
                                // radius: Radius.circular(5),
                                dashPattern: const [5],
                                customPath: (size) {
                                  return Path()
                                    ..moveTo(0, size.height)
                                    ..lineTo(size.width, size.height);
                                },
                                child: Container(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)!.total_amount,
                                    style: const TextStyle(
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "${memberShipPackage.price} ${AppLocalizations.of(context)!.sar}",
                                    style: const TextStyle(
                                        color: AppColors.primaryDark,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  paymentDetails(memberShipPackage),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paymentDetails(memberShipPackage) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      decoration: ShapeDecoration(
        shape: WeirdBorder(
          radius: 10,
          pathWidth: 1000,
        ),
        color: AppColors.white,
      ),
      child: Column(
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
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is PaymentMethodsSuccessState) {
                setState(() {
                  paymentId = state.paymentMethods[0]['id'];
                });
              }
            },
            builder: (context, state) {
              return AppConditionalBuilder(
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
              );
            },
          ),
          paymentButton(memberShipPackage),
        ],
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

  Widget paymentButton(memberShipPackage) {
    return BlocProvider(
      create: (context) => MembershipCubit(),
      child: BlocConsumer<MembershipCubit, MembershipState>(
        listener: (context, state) {
          if (state is CheckoutMemberShipSuccessState) {
            Navigator.of(context).pushNamed(
              AppRoutes.paymentWebViewScreen,
              arguments: {'url': state.data['payment_url']},
            );
          }
          if (state is CheckoutMemberShipErrorState) {
            AppSnackBar.showError(context, state.error);
          }
        },
        builder: (context, state) {
          MembershipCubit cubit = MembershipCubit.get(context);
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: AppButton(
              title: AppLocalizations.of(context)!.payment,
              width: 200,
              loading: state is CheckoutMemberShipLoadingState,
              onPressed: () {
                cubit.checkout({
                  'payment_method_id': paymentId,
                  'membership_id': memberShipPackage.id
                });
              },
            ),
          );
        },
      ),
    );
  }
}
