import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendas/models/product.dart';
import 'package:vendas/network/network_service.dart';
import 'package:vendas/network/network_statics.dart';

class FavoriteProductController {
  String favoriteProductUrl = NetWorkStatics().createUrl("/favorite-product");

  // Future<List<Product>> getAll(String token) async {
  //   Map<String, String> headers = {
  //     'Authorization': token,
  //   };

  //   http.Response response = await NetworkService.createRequest(
  //       favoriteProductUrl, headers, RequestType.get, {});

  //   if (response.statusCode != 201 && response.statusCode != 200) {
  //     throw Exception('Produtos Favoritos não encontrados');
  //   }

  //   List<Product> products = [];

  //   for (final product in jsonDecode(response.body)) {
  //     products.add(Product().fromMap(product));
  //   }

  //   return products;
  // }

  Future<bool> create(String token, int productId) async {
    Map<String, String> headers = {
      'Authorization': token,
    };
    http.Response response = await NetworkService.createRequest(
        '${favoriteProductUrl}/$productId', headers, RequestType.post, {});

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao favoritar');
    }
    return true;
  }

  Future<bool> delete(String token, int productId) async {
    Map<String, String> headers = {
      'Authorization': token,
    };

    http.Response response = await NetworkService.createRequest(
        '${favoriteProductUrl}/$productId', headers, RequestType.delete, {});
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao desfavoritar');
    }

    return true;
  }
}
