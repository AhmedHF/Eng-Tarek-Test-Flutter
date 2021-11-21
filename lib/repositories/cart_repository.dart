import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class CartRepository implements CartInterface {
  final CartDataProvider cartDataProvider;
  CartRepository(this.cartDataProvider);

  @override
  Future<AppResponse> addItemToCart(Map<String, dynamic> data) {
    return cartDataProvider.addItemToCart(data);
  }

  @override
  Future<AppResponse> deleteItemFromCart(int id) {
    return cartDataProvider.deleteItemFromCart(id);
  }

  @override
  Future<AppResponse> getCartItems() {
    return cartDataProvider.getCartItems();
  }

  @override
  Future<AppResponse> updateItemInCart(data) {
    return cartDataProvider.updateItemInCart(data);
  }

  @override
  Future<AppResponse> checkout(data) {
    return cartDataProvider.checkout(data);
  }

  @override
  Future<AppResponse> getCartTotalPrice() {
    return cartDataProvider.getCartTotalPrice();
  }

  @override
  Future<AppResponse> getPaymentMethods() {
    return cartDataProvider.getPaymentMethods();
  }
}
