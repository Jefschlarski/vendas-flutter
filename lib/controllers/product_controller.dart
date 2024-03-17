import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendas/models/product.dart';
import 'package:vendas/network/network_service.dart';
import 'package:vendas/network/network_statics.dart';

class ProductController {
  String productUrl = NetWorkStatics().createUrl("/product");

  Future<List<Product>> getAll(String token) async {
    Map<String, String> headers = {
      'Authorization': token,
    };

    http.Response response = await NetworkService.createRequest(
        productUrl, headers, RequestType.get, {});

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Produtos não encontrados');
    }

    List<Product> products = [];

    for (final product in jsonDecode(response.body)) {
      products.add(Product().fromMap(product));
    }

    return products;
  }
}
