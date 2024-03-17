import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendas/models/cart.dart';
import 'package:vendas/models/dto/cart_product_dto.dart';
import 'package:vendas/network/network_service.dart';
import 'package:vendas/network/network_statics.dart';

class CartController {
  String cartUrl = NetWorkStatics().createUrl("/cart");

  Future<Cart> get(String token) async {
    Map<String, String> headers = {
      'Authorization': token,
    };

    http.Response response = await NetworkService.createRequest(
        cartUrl, headers, RequestType.get, {});
    if (response.statusCode == 404) {
      throw Exception('Produto não encontrado');
    } else if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao carregar carrinho');
    }

    return Cart().fromMap(jsonDecode(response.body));
  }

  Future<bool> addProduct(String token, CartProductDto cartProductDto) async {
    Map<String, String> headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };

    http.Response response = await NetworkService.createRequest(
        cartUrl, headers, RequestType.post, jsonEncode(cartProductDto.toMap()));

    if (response.statusCode == 404) {
      throw Exception('Produto não encontrado');
    } else if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao adicionar produto');
    }

    return true;
  }

  Future<bool> updateProduct(
      String token, CartProductDto cartProductDto) async {
    Map<String, String> headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };

    http.Response response = await NetworkService.createRequest(
        cartUrl, headers, RequestType.put, jsonEncode(cartProductDto.toMap()));

    if (response.statusCode == 404) {
      throw Exception('Produto não encontrado');
    } else if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao alterar produto');
    }

    return true;
  }

  Future<bool> clean(String token) async {
    Map<String, String> headers = {'Authorization': token};

    http.Response response = await NetworkService.createRequest(
        "$cartUrl/clean", headers, RequestType.put, {});

    if (response.statusCode != 201 && response.statusCode != 200) {
      print(response.body);
      throw Exception('Erro ao limpar o carrinho');
    }

    return true;
  }
}
