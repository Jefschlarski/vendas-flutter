import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  late int _id;
  late String _name;
  late String _email;
  late String _phone;
  late String _cpf;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get cpf => _cpf;

  User fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _email = map['email'];
    _phone = map['phone'];
    _cpf = map['cpf'];
    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'phone': _phone,
      'cpf': _cpf
    };
  }
}
