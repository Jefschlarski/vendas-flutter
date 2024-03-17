import 'package:flutter/material.dart';
import 'package:vendas/controllers/cart_controller.dart';
import 'package:vendas/models/cart.dart';
import 'package:vendas/models/cart_product.dart';
import 'package:vendas/models/dto/cart_product_dto.dart';

class CartProvider extends ChangeNotifier {
  late Cart cart;
  int cartId = 0;
  double cartPrice = 0;
  List<CartProduct> cartProducts = [];

  createProvider(Cart value) {
    cart = value;
    cartId = cart.id;
    cartPrice = cart.cartPrice;
    cartProducts = cart.cartProducts;
  }

  incrementProducts(String token, CartProduct cartProduct) async {
    CartProductDto cartProductDto = CartProductDto(
        productId: cartProduct.product.id, amount: cartProduct.amount + 1);
    await CartController()
        .updateProduct(token, cartProductDto)
        .then((value) => notifyListeners());
  }

  decrementProducts(String token, CartProduct cartProduct) {
    CartProductDto cartProductDto = CartProductDto(
        productId: cartProduct.product.id, amount: cartProduct.amount - 1);
    CartController()
        .updateProduct(token, cartProductDto)
        .then((value) => notifyListeners());
  }

  Future<bool> cleanCart(String token) async {
    final confirmation = await CartController().clean(token);
    notifyListeners();
    return confirmation;
  }
}
