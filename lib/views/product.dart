import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas/controllers/cart_controller.dart';
import 'package:vendas/models/auth.dart';
import 'package:vendas/models/product.dart';
import 'package:vendas/utils/formater.dart';
import 'package:vendas/utils/snackbar.dart';
import 'package:vendas/views/cart.dart';
import 'package:vendas/views/common/app_bar.dart';
import 'package:vendas/views/providers/product_provider.dart';

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: CommonAppBar(title: product.name),
        body: PopScope(
          onPopInvoked: (value) {
            productProvider.clear();
          },
          child: Center(
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: product.favorite != null
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border_outlined)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: ${Formarter.formatarParaReais(product.price)}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.network(
                      product.image,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Category: ${product.category.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: productProvider.decrementAmount,
                            ),
                            Text(
                              '${productProvider.amount}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: productProvider.incrementAmount,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await CartController()
                                .addProduct(
                                    provider.auth.accessToken,
                                    productProvider
                                        .createCartProductDto(product.id))
                                .then((value) => {
                                      SnackBarUtils.show(
                                          'Produto adicionado com sucesso ao carrinho!',
                                          context),
                                      productProvider.clear()
                                    });
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
