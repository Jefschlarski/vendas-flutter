import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas/controllers/cart_controller.dart';
import 'package:vendas/models/auth.dart';
import 'package:vendas/models/cart.dart';
import 'package:vendas/utils/formater.dart';
import 'package:vendas/views/common/app_bar.dart';
import 'package:vendas/views/providers/cart_provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: const CommonAppBar(title: 'Carrinho'),
        body: FutureBuilder<Cart>(
            future: CartController().get(provider.auth.accessToken),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child:
                      CircularProgressIndicator(), // Show loading indicator while waiting for data
                );
              } else if (snapshot.hasError ||
                  snapshot.data!.cartProducts.isEmpty) {
                return const Center(child: Text('Carrinho vazio'));
              } else {
                cartProvider.createProvider(snapshot.data!);
                final cart = cartProvider.cart;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.cartProducts.length,
                        itemBuilder: (context, index) {
                          final cartProduct = cart.cartProducts[index];
                          return ListTile(
                            title: Text(cartProduct.product.name),
                            subtitle: Text('Quantidade: ${cartProduct.amount}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(Formarter.formatarParaReais(
                                    cartProduct.getTotalPrice())),
                                IconButton(
                                  onPressed: () {
                                    cartProvider.incrementProducts(
                                        provider.auth.accessToken, cartProduct);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartProvider.decrementProducts(
                                        provider.auth.accessToken, cartProduct);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                              'Total: ${Formarter.formatarParaReais(cart.cartPrice)}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final confirmation = await cartProvider
                                      .cleanCart(provider.auth.accessToken);
                                  if (confirmation) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text('Carrinho limpo com sucesso'),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Erro ao limpar carrinho'),
                                      duration: Duration(seconds: 5),
                                    ));
                                  }
                                },
                                child: Text('Limpar Carrinho'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para finalizar o carrinho
                                },
                                child: Text('Finalizar Compra'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
