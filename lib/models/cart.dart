import 'package:vendas/models/cart_product.dart';

class Cart {
  late int _id;
  late double _cartPrice;
  late List<CartProduct> _cartProducts;

  late Cart cart;

  setCart(Cart value) {
    cart = value;
  }

  int get id => _id;
  double get cartPrice => _cartPrice;
  List<CartProduct> get cartProducts => _cartProducts;

  Cart fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _cartPrice = double.parse(map['cartPrice'].toString());

    if (map['cartProducts'] != null) {
      _cartProducts = [];
      map['cartProducts'].forEach((v) {
        _cartProducts.add(CartProduct().fromMap(v));
      });
    }

    return this;
  }
}

/**
 * 
 * {
    "id": 7,
    "cartPrice": 101,
    "cartProducts": [
        {
            "id": 18,
            "cartId": 7,
            "productId": 2,
            "amount": 1,
            "product": {
                "id": 2,
                "name": "Liquidificador atualizado",
                "price": 101,
                "image": "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                "category": {
                    "id": 2,
                    "name": "Moveis"
                }
            }
        }
    ]
}
 */
