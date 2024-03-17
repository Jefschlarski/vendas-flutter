import 'package:flutter/material.dart';
import 'package:vendas/controllers/favorite_product_controller.dart';
import 'package:vendas/models/dto/cart_product_dto.dart';

class ProductProvider extends ChangeNotifier {
  int amount = 1;

  incrementAmount() {
    amount++;
    notifyListeners();
  }

  decrementAmount() {
    amount > 1 ? amount-- : amount;
    notifyListeners();
  }

  clear() {
    amount = 1;
    notifyListeners();
  }

  CartProductDto createCartProductDto(productId) {
    CartProductDto cartProductDto =
        CartProductDto(productId: productId, amount: amount);
    notifyListeners();
    return cartProductDto;
  }

  toggleFavorite(String token, int productId, bool? isFavorite) async {
    if (isFavorite != null) {
      await FavoriteProductController()
          .delete(token, productId)
          .then((value) => notifyListeners());
    } else {
      await FavoriteProductController()
          .create(token, productId)
          .then((value) => notifyListeners());
    }
    notifyListeners();
  }
}
