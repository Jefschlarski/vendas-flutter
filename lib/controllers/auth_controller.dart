import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendas/models/auth.dart';
import 'package:vendas/network/network_service.dart';
import 'package:vendas/network/network_statics.dart';

class AuthController {
  String authUrl = NetWorkStatics().createUrl("/auth");

  Future<Auth> login(String email, String password) async {
    http.Response response = await NetworkService.createRequest(
        authUrl, {}, RequestType.post, {"email": email, "password": password});
    print(response.statusCode);
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Email ou senha invalido');
    }

    return Auth().fromMap(jsonDecode(response.body));
  }
}
