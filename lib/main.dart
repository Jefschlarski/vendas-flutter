import 'package:flutter/material.dart';
import 'package:vendas/models/auth.dart';
import 'package:vendas/models/cart.dart';
import 'package:vendas/views/login.dart';
import 'package:provider/provider.dart';
import 'package:vendas/views/providers/cart_provider.dart';
import 'package:vendas/views/providers/product_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginForm(),
      )));
}
