import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/widgets/alert_dialogs/login_alert_dialog.dart';
import 'package:value_client/widgets/app_loading.dart';
import 'package:value_client/widgets/app_snack_bar.dart';
import 'package:value_client/widgets/branch_list_btn.dart';
import 'package:value_client/widgets/offer_details_timer.dart';
import 'package:value_client/widgets/weird_border.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfferDetailsInfo extends StatefulWidget {
  final Map<String, dynamic> data;
  const OfferDetailsInfo({Key? key, required this.data}) : super(key: key);

  @override
  _OfferDetailsInfoState createState() => _OfferDetailsInfoState();
}

class _OfferDetailsInfoState extends State<OfferDetailsInfo> {
  var count = 1;
  void _increase() {
    setState(() {
      count++;
    });
  }

  void _decrease() {
    if (count == 1) {
      return;
    }
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('====== ${widget.data['store']}');
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
              shape: WeirdBorder(radius: 10, pathWidth: 1000),
              color: AppColors.backgroundGrey),
          margin: const EdgeInsets.only(top: 5),
          // padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.data['name'],
                  style: const TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.data['description'],
                  style: const TextStyle(
                      color: AppColors.primaryDark, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 28.0,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: widget.data['users'].runtimeType == String
                    ? Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 25,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppColors.grayText,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          widget.data['users'],
                          style: const TextStyle(color: AppColors.white),
                        ),
                      )
                    : ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              color: AppColors.grayText,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            widget.data['users'][index]['name'],
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: widget.data['users'].length,
                      ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          child: Text(
                            widget.data['price'] == "0"
                                ? AppLocalizations.of(context)!.free
                                : widget.data['price'],
                            style: const TextStyle(
                                color: AppColors.white, fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                              color: widget.data['price'] == "0"
                                  ? AppColors.red
                                  : AppColors.primaryL,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        widget.data['price_before_discount'] != "" &&
                                widget.data['price_before_discount'] != null
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  '${widget.data['price_before_discount']} ${AppLocalizations.of(context)!.sar}',
                                  style: const TextStyle(
                                      color: AppColors.textGray,
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: _increase,
                            child: Container(
                              width: 35,
                              height: 35,
                              // padding: EdgeInsets.all(5),
                              child: const Icon(
                                AppIcons.add,
                                color: AppColors.white,
                                size: 20,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryL,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              count.toString(),
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            width: 55,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.backgroundGray,
                                    width: 1.5)),
                          ),
                          InkWell(
                            onTap: _decrease,
                            child: Container(
                              width: 35,
                              height: 35,
                              // padding: EdgeInsets.all(5),
                              child: const Icon(
                                AppIcons.minus_sign,
                                color: AppColors.white,
                                size: 20,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryL,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // border: Border.all(color: AppColors.primaryDark, width: 1)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     "*The offer is not applicable to all branches",
              //     style: TextStyle(
              //       color: AppColors.red,
              //       fontSize: 10,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OfferDetailsTimer(
                  data: widget.data,
                ),
              ),
              const SizedBox(height: 20),
              addToCart(widget.data, count),
              const SizedBox(height: 25),
            ],
          ),
        ),
        BranchListBtn(
          AppColors.white,
          AppRoutes.searchBranchListScreen,
          widget.data['store']['working_from'],
          widget.data['store']['working_to'],
          widget.data['branches'],
        ),
      ],
    );
  }
}

Widget addToCart(data, count) {
  return BlocConsumer<CartCubit, CartState>(listener: (context, state) {
    if (state is AddItemErrorState) {
      AppSnackBar.showError(context, state.error);
    } else if (state is AddItemSuccessState) {
      AppSnackBar.showSuccess(context, state.message);
    }
  }, builder: (context, state) {
    CartCubit cubit = CartCubit.get(context);
    AppCubit appCubit = AppCubit.get(context);

    return ElevatedButton(
      onPressed: () {
        if (state is AddItemLoadingState) return;
        if (appCubit.userData.user == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const LoginAlertDialog(),
          );
        } else {
          cubit.addItemInCart(data['id'] as int, count as int);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            data['price'] == "0" ? Icons.local_offer_outlined : AppIcons.cart,
            color: AppColors.white,
          ),
          const SizedBox(width: 5),
          state is AddItemLoadingState
              ? const AppLoading(
                  scale: .5,
                )
              : Text(
                  data['price'] == "0"
                      ? AppLocalizations.of(context)!.add_to_my_value
                      : AppLocalizations.of(context)!.add_to_cart,
                  style: const TextStyle(
                    color: AppColors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        primary: AppColors.accentL,
        padding: const EdgeInsets.all(15),
      ),
    );
  });
}
