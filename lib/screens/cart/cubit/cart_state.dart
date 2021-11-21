part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

/// get cart items
class CartItemsLoadingState extends CartState {}

class CartItemsSuccessState extends CartState {
  final List<CartModel> cartItems;
  const CartItemsSuccessState(this.cartItems);
}

class CartItemsErrorState extends CartState {
  final String error;
  const CartItemsErrorState(this.error);
}

/// add item to cart
class AddItemLoadingState extends CartState {}

class AddItemSuccessState extends CartState {
  final String message;
  const AddItemSuccessState(this.message);
}

class AddItemErrorState extends CartState {
  final String error;
  const AddItemErrorState(this.error);
}

/// update item in cart
class UpdateItemLoadingState extends CartState {
  final int id;
  const UpdateItemLoadingState(this.id);
}

class UpdateItemSuccessState extends CartState {
  final List<CartModel> updateItem;
  final String message;
  const UpdateItemSuccessState(this.updateItem, this.message);
}

class UpdateItemErrorState extends CartState {
  final String error;
  const UpdateItemErrorState(this.error);
}

/// delete item from cart
class DeleteItemLoadingState extends CartState {
  final int id;
  const DeleteItemLoadingState(this.id);
}

class DeleteItemSuccessState extends CartState {
  final List<CartModel> deleteItem;
  final String message;
  const DeleteItemSuccessState(this.deleteItem, this.message);
}

class DeleteItemErrorState extends CartState {
  final String error;
  const DeleteItemErrorState(this.error);
}

/// checkout
class CheckoutLoadingState extends CartState {}

class CheckoutSuccessState extends CartState {
  final Map<String, dynamic> data;
  const CheckoutSuccessState(this.data);
}

class CheckoutErrorState extends CartState {
  final String error;
  const CheckoutErrorState(this.error);
}

/// get cart total price
class CartTotalPriceLoadingState extends CartState {}

class CartTotalPriceSuccessState extends CartState {
  // final Map<String, dynamic> data;
  const CartTotalPriceSuccessState();
}

class CartTotalPriceErrorState extends CartState {
  final String error;
  const CartTotalPriceErrorState(this.error);
}

/// get payment methods
class PaymentMethodsLoadingState extends CartState {}

class PaymentMethodsSuccessState extends CartState {
  final List<dynamic> paymentMethods;
  const PaymentMethodsSuccessState(this.paymentMethods);
}

class PaymentMethodsErrorState extends CartState {
  final String error;
  const PaymentMethodsErrorState(this.error);
}
