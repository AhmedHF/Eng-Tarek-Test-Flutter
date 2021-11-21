import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/models/discount.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/my_value/cubit/my_values_cubit.dart';
import 'package:value_client/screens/purchased_coupon/cubit/gift_cubit.dart';
import 'package:value_client/widgets/index.dart';
import 'package:value_client/core/extensions/extensions.dart';

class PurchasedCouponScreen extends StatefulWidget {
  const PurchasedCouponScreen({Key? key}) : super(key: key);

  @override
  _PurchasedCouponScreenState createState() => _PurchasedCouponScreenState();
}

class _PurchasedCouponScreenState extends State<PurchasedCouponScreen> {
  bool isSendGift = false;
  final TextEditingController phone = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    debugPrint('arguments==>${arguments['id'].toString()}');
    return BlocProvider(
        create: (context) =>
            MyValuesCubit()..getUserCouponDetails(arguments['id'].toString()),
        child: Scaffold(
          appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.purchased_coupon)),
          body: NetworkSensitive(
            child: Stack(children: <Widget>[
              Image.asset(
                AppImages.background,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              BlocBuilder<MyValuesCubit, MyValuesState>(
                  builder: (context, state) {
                return AppConditionalBuilder(
                    loadingCondition: state is UserCouponDetailsLoadingState,
                    loadingColor: AppColors.white,
                    emptyCondition: state is UserCouponDetailsSuccessState &&
                        state.userCouponDetails.isEmpty,
                    errorCondition: state is UserCouponDetailsErrorState,
                    errorMessage:
                        state is UserCouponDetailsErrorState ? state.error : '',
                    successCondition: state is UserCouponDetailsSuccessState,
                    successBuilder: (context) => state
                            is UserCouponDetailsSuccessState
                        ? SingleChildScrollView(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipPath(
                                  clipper: FullTicketClipper(10, 200),
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.backgroundGrey,
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: DottedBorder(
                                        color: AppColors.gray,
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 30),
                                        strokeWidth: 2,
                                        dashPattern: [5],
                                        customPath: (size) {
                                          return Path()
                                            ..moveTo(5, size.height)
                                            ..lineTo(
                                                size.width - 5, size.height);
                                        },
                                        child: ValueItem(
                                          item: DiscountModel(
                                            id: state
                                                    .userCouponDetails['coupon']
                                                ['id'],
                                            name: state
                                                    .userCouponDetails['coupon']
                                                ['name'],
                                            description: state
                                                    .userCouponDetails['coupon']
                                                ['description'],
                                            image: state
                                                    .userCouponDetails['coupon']
                                                ['image'],
                                            expire: state
                                                    .userCouponDetails['coupon']
                                                ['expire'],
                                            price: state
                                                    .userCouponDetails['coupon']
                                                ['price'],
                                            priceBeforeDiscount: state
                                                    .userCouponDetails['coupon']
                                                ['price_before_discount'],
                                            storeName: state
                                                    .userCouponDetails['coupon']
                                                ['store']['store_name'],
                                            storeImage: state
                                                    .userCouponDetails['coupon']
                                                ['store']['image'],
                                            expireDate: state
                                                .userCouponDetails['expire_at'],
                                          ),
                                          onPress: () => {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: ShapeDecoration(
                                    shape: WeirdBorder(
                                      radius: 10,
                                      pathWidth: 1000,
                                    ),
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: DottedBorder(
                                    color: AppColors.gray,
                                    strokeWidth: 2,
                                    dashPattern: [5],
                                    customPath: (size) {
                                      return Path()
                                        ..moveTo(0, size.height)
                                        ..lineTo(size.width, size.height);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 40,
                                        ),
                                        ExpandablePanel(
                                            header: Text(
                                              state.userCouponDetails['coupon']
                                                  ['name'],
                                              softWrap: true,
                                              style: TextStyle(
                                                color: AppColors.primaryDark,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Text(state
                                                        .userCouponDetails[
                                                    'coupon']['description']))),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  AppRoutes
                                                      .purchasedCouponDetailsScreen,
                                                  arguments:
                                                      state.userCouponDetails);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .redeem,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(250, 40),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                primary: AppColors.accentL,
                                                padding: EdgeInsets.all(15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: ShapeDecoration(
                                    shape: WeirdBorder(
                                      radius: 10,
                                      pathWidth: 1000,
                                    ),
                                    color: AppColors.backgroundGrey,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      border: Border.all(
                                                        color:
                                                            AppColors.textGray,
                                                        width: 1.0,
                                                      )),
                                                  child: Icon(
                                                    Icons.wallet_giftcard_sharp,
                                                    color: AppColors.textGray,
                                                    size: 25,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .send_as_gift,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryDark,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              // checkColor: AppColors.accentL,
                                              // activeColor: AppColors.grayText,
                                              value: isSendGift,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSendGift = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SendGift(
                                          form: _form,
                                          phone: phone,
                                          isSendGift: isSendGift,
                                          arguments: arguments),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container());
              })
            ]),
          ),
        ));
  }
}

class SendGift extends StatelessWidget {
  const SendGift({
    Key? key,
    required GlobalKey<FormState> form,
    required this.phone,
    required this.isSendGift,
    required this.arguments,
  })  : _form = form,
        super(key: key);

  final GlobalKey<FormState> _form;
  final TextEditingController phone;
  final bool isSendGift;
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiftCubit, GiftStates>(listener: (context, state) {
      if (state is SendGiftErrorState) {
        debugPrint('error gift${state.error.toString()}');
        AppSnackBar.showError(context, state.error.toString());
      }
      if (state is SendGiftSuccessState) {
        AppSnackBar.showSuccess(context, AppLocalizations.of(context)!.done);
        debugPrint('success gift${state.toString()}');
      }
    }, builder: (context, state) {
      GiftCubit cubit = GiftCubit.get(context);

      return Form(
          key: _form,
          child: AutofillGroup(
              child: Column(children: <Widget>[
            TextFormField(
              textAlign: TextAlign.center,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.phone,
              controller: phone,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phoneNumber,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  // focusColor: AppColors.secondaryL,
                  hintStyle: TextStyle(color: AppColors.black),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.backgroundGray,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.backgroundGray,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  )),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .please_enter_phone_number;
                } else if (value.isValidPhone) {
                  return null;
                } else {
                  return AppLocalizations.of(context)!
                      .please_enter_valid_phone_number;
                }
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              alignment: Alignment.center,
              child: AppButton(
                onPressed: () {
                  if (state is SendGiftLoadingState) {
                    return;
                  }
                  if (!isSendGift) {
                    return;
                  } else {
                    final isValid = _form.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    cubit.sendGift({
                      'user_coupon_id': arguments['id'],
                      'phone': phone.text
                    });
                    // Navigator.of(context)
                    //     .pushNamed(AppRoutes.paymentDetailsScreen);
                  }
                },
                loading: state is SendGiftLoadingState,
                title: AppLocalizations.of(context)!.send,
                width: 220,
                backgroundColor:
                    isSendGift ? AppColors.accentL : AppColors.backgroundGray,
              ),
            ),
          ])));
    });
  }
}
