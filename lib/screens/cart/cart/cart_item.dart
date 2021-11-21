import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/models/cart.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/widgets/alert_dialogs/custom_alert_dialog.dart';
import 'package:value_client/widgets/index.dart';

class CartItem extends StatelessWidget {
  final CartModel item;
  const CartItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.description,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                renderPrice(context),
                renderCount(context),
                deleteButton(context),
              ],
            ),
          ),
          lineBorder(),
        ],
      ),
    );
  }

  Widget renderCount(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            CartCubit cubit = CartCubit.get(context);
            if (cubit.currentItemId == item.id) {
              if (state is UpdateItemErrorState) {
                AppSnackBar.showError(context, state.error);
              } else if (state is UpdateItemSuccessState) {
                AppSnackBar.showSuccess(context, state.message);
              }
            }
          },
          builder: (context, state) {
            CartCubit cubit = CartCubit.get(context);
            if (state is UpdateItemLoadingState &&
                cubit.currentItemId == item.id) {
              return const AppLoading(
                color: AppColors.primaryL,
                scale: 0.4,
              );
            } else {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryL, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.primaryL,
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              maxHeight: 30,
                            ),
                            icon: const Icon(
                              Icons.add_circle,
                              size: 20,
                            ),
                            onPressed: () {
                              if ((item.qty < item.remain) &&
                                  (item.qty < item.couponNumberPerUser)) {
                                cubit.updateItemInCart(item.id, item.qty + 1);
                              } else if (item.qty >= item.remain) {
                                AppSnackBar.showError(
                                  context,
                                  AppLocalizations.of(context)!
                                          .number_coupons_available +
                                      ' ${item.remain}',
                                );
                              } else if (item.qty >= item.couponNumberPerUser) {
                                AppSnackBar.showError(
                                  context,
                                  AppLocalizations.of(context)!
                                          .coupons_available_for_you +
                                      ' ${item.couponNumberPerUser}',
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          item.qty.toString(),
                          style: const TextStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.primaryL,
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              maxHeight: 30,
                            ),
                            icon: const Icon(
                              Icons.remove_circle,
                              size: 20,
                            ),
                            onPressed: () {
                              if (item.qty > 1) {
                                cubit.updateItemInCart(item.id, item.qty - 1);
                              } else if (item.qty == 1) {
                                cubit.deleteItemFromCart(item.id);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget renderPrice(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryL, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                '${item.price.toString()} ${AppLocalizations.of(context)!.sar}',
                style: const TextStyle(color: AppColors.primaryL, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteButton(context1) {
    return Expanded(
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          if (cubit.currentItemId == item.id) {
            if (state is DeleteItemErrorState) {
              debugPrint('=== errrrrror ');
              AppSnackBar.showError(context, state.error);
            } else if (state is DeleteItemSuccessState) {
              debugPrint('=== message ');
              AppSnackBar.showSuccess(context, state.message);
            }
          }
        },
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          if (state is DeleteItemLoadingState &&
              cubit.currentItemId == item.id) {
            return const AppLoading(
              color: AppColors.primaryL,
              scale: 0.4,
            );
          } else {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title:
                          AppLocalizations.of(context)!.delete_item_from_cart,
                      onPressedYes: () {
                        debugPrint('onPressedYes');
                        Navigator.pop(context, 'Ok');
                        cubit.deleteItemFromCart(item.id);
                      },
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(
                    AppIcons.delete,
                    color: AppColors.red,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.delete,
                    style: const TextStyle(color: AppColors.red, fontSize: 16),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
