import 'package:vendas/models/category.dart';

class Product {
  late int _id;
  late String _name;
  late double _price;
  late String _image;
  late Category _category;
  late bool? _favorite;

  int get id => _id;
  String get name => _name;
  double get price => _price;
  String get image => _image;
  Category get category => _category;
  bool? get favorite => _favorite;

  Product fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _price = double.parse(map['price'].toString());
    _image = map['image'];
    _category = Category().fromMap(map['category']);
    _favorite = map['favorite'];
    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'price': _price,
      'image': _image,
      'category': _category.toMap(),
      'favorite': _favorite
    };
  }
}
