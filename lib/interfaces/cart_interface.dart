import 'package:value_client/models/index.dart';

abstract class CartInterface {
  Future<AppResponse> getCartItems();
  Future<AppResponse> addItemToCart(Map<String, dynamic> data);
  Future<AppResponse> updateItemInCart(Map<String, dynamic> data);
  Future<AppResponse> deleteItemFromCart(int id);
  Future<AppResponse> checkout(Map<String, dynamic> data);
  Future<AppResponse> getCartTotalPrice();
  Future<AppResponse> getPaymentMethods();
}
