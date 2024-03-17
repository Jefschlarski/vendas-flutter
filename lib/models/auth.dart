import 'package:flutter/material.dart';
import 'package:vendas/models/user.dart';

class Auth extends ChangeNotifier {
  late String _accessToken;
  late User _user;

  late Auth auth;

  String get accessToken => _accessToken;
  User get user => _user;

  Auth fromMap(Map<String, dynamic> map) {
    _accessToken = map['accessToken'];
    _user = User().fromMap(map['user']);

    return this;
  }

  setAuth(Auth auth) {
    this.auth = auth;
  }
}
