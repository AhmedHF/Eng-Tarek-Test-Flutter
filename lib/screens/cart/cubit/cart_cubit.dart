import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/cart.dart';
import 'package:value_client/repositories/index.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  static final dataProvider = CartDataProvider();
  static final CartRepository repository = CartRepository(dataProvider);

  List<CartModel> cartItems = [];
  Map<String, dynamic> totalPrice = {};
  int currentItemId = -1;

  /// get cart items
  void getCartItems() {
    cartItems = [];
    emit(CartItemsLoadingState());
    repository.getCartItems().then(
      (value) {
        if (value.errorMessages != null) {
          emit(CartItemsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CartItemsErrorState(value.errors!));
        } else {
          value.data.forEach((item) {
            cartItems.add(CartModel(
              id: item['id'],
              qty: item['qty'],
              price: int.parse(item['coupon']['price']),
              description: item['coupon']['description'],
              offer: item['coupon']['discount_amount'],
              remain: item['coupon']['remain'],
              couponNumberPerUser: item['coupon']['coupon_number_per_user'],
            ));
          });
          emit(CartItemsSuccessState(cartItems));
        }
      },
    );
  }

  /// add item to cart
  void addItemInCart(int couponId, int qty) {
    emit(AddItemLoadingState());
    Map<String, dynamic> data = {
      'cart[0][coupon_id]': couponId,
      'cart[0][qty]': qty,
    };
    repository.addItemToCart(data).then(
      (value) {
        if (value.errorMessages != null) {
          emit(AddItemErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(AddItemErrorState(value.errors!));
        } else {
          emit(AddItemSuccessState(value.data));
        }
      },
    );
  }

  /// update items in cart
  void updateItemInCart(int id, int newQuantity) {
    currentItemId = id;
    emit(UpdateItemLoadingState(id));
    Map<String, dynamic> data = {
      'cart_id': id,
      'qty': newQuantity,
    };
    repository.updateItemInCart(data).then(
      (value) {
        if (value.errorMessages != null) {
          emit(UpdateItemErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UpdateItemErrorState(value.errors!));
        } else {
          int index = cartItems.indexWhere((item) => item.id == id);
          cartItems[index].qty = newQuantity;
          emit(UpdateItemSuccessState(cartItems, value.data));
        }
      },
    );
  }

  /// delete items from cart
  void deleteItemFromCart(int id) {
    currentItemId = id;
    emit(DeleteItemLoadingState(id));
    repository.deleteItemFromCart(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(DeleteItemErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(DeleteItemErrorState(value.errors!));
        } else {
          cartItems.removeWhere((item) => item.id == id);
          emit(DeleteItemSuccessState(cartItems, value.data));
        }
      },
    );
  }

  /// checkout
  void checkout(int paymentId) {
    emit(CheckoutLoadingState());
    Map<String, dynamic> data = {
      'payment_method_id': paymentId,
    };
    repository.checkout(data).then(
      (value) {
        debugPrint('VALUE payment_method_id : $value}', wrapWidth: 1024);
        if (value.errorMessages != null) {
          emit(CheckoutErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CheckoutErrorState(value.errors!));
        } else {
          emit(CheckoutSuccessState(value.data));
        }
      },
    );
  }

  ///  cart total price
  void getCartTotalPrice() {
    emit(CartTotalPriceLoadingState());
    repository.getCartTotalPrice().then(
      (value) {
        if (value.errorMessages != null) {
          emit(CartTotalPriceErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CartTotalPriceErrorState(value.errors!));
        } else {
          totalPrice = value.data;
          emit(const CartTotalPriceSuccessState());
        }
      },
    );
  }

  /// get payment methods
  void getPaymentMethods() {
    emit(PaymentMethodsLoadingState());
    repository.getPaymentMethods().then(
      (value) {
        if (value.errorMessages != null) {
          emit(PaymentMethodsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(PaymentMethodsErrorState(value.errors!));
        } else {
          emit(PaymentMethodsSuccessState(value.data));
        }
      },
    );
  }
}
