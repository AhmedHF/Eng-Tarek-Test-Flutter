import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/cart/cart/cart_item.dart';
import 'package:value_client/screens/cart/cubit/cart_cubit.dart';
import 'package:value_client/widgets/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    CartCubit cubit = CartCubit.get(context);
    cubit.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppCubit cubit = AppCubit.get(context);
        Scaffold.of(context).openEndDrawer();
        cubit.onItemTapped(0);
        return false;
      },
      child: Scaffold(
        body: NetworkSensitive(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipPath(
              clipper: FullTicketClipper(
                  10, MediaQuery.of(context).size.height - 150),
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: cartList(),
                    ),
                    checkoutButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cartList() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        if (state is CartItemsLoadingState) {
          return const AppLoading(color: AppColors.primaryL);
        } else if (cubit.cartItems.isEmpty) {
          return emptyWidget(context);
        } else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                CartItem(item: cubit.cartItems[index]),
            separatorBuilder: (context, index) => const SizedBox(
              width: 5,
            ),
            itemCount: cubit.cartItems.length,
          );
        }
      },
    );
  }

  Widget checkoutButton(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    CartCubit cartCubit = CartCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppButton(
        title: AppLocalizations.of(context)!.checkout,
        width: 200,
        onPressed: () {
          if (cubit.userData.user == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const LoginAlertDialog(),
            );
          } else if (cartCubit.cartItems.isEmpty) {
            AppSnackBar.showInfo(
                context, AppLocalizations.of(context)!.empty_cart);
          } else {
            Navigator.of(context).pushNamed(AppRoutes.checkoutScreen);
          }
        },
      ),
    );
  }

  Widget emptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, right: 20),
                child: DottedBorder(
                  color: AppColors.gray,
                  dashPattern: const [5],
                  borderType: BorderType.Circle,
                  child: Container(
                    height: 155,
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: Center(
                  child: Icon(
                    AppIcons.icon_cart,
                    color: AppColors.gray,
                    size: 200,
                  ),
                ),
              ),
            ],
          ),
          Text(AppLocalizations.of(context)!.empty_cart),
          Text(AppLocalizations.of(context)!.fill_cart),
        ],
      ),
    );
  }
}
