import 'package:vendas/models/product.dart';

class CartProduct {
  late int _id;
  late int _cartId;
  late int _productId;
  late int amount;
  late Product _product;

  int get id => _id;
  int get cartId => _cartId;
  int get productId => _productId;
  Product get product => _product;

  CartProduct fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _cartId = map['cartId'];
    _productId = map['productId'];
    amount = map['amount'];
    _product = Product().fromMap(map['product']);

    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'cartId': _cartId,
      'productId': _productId,
      'amount': amount,
      'product': _product.toMap(),
    };
  }

  double getTotalPrice() {
    return amount * _product.price;
  }
}
