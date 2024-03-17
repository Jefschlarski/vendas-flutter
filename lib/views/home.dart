import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas/controllers/product_controller.dart';
import 'package:vendas/models/auth.dart';
import 'package:vendas/models/product.dart';
import 'package:vendas/views/common/product_tile.dart';
import 'package:vendas/views/common/app_bar.dart';
import 'package:vendas/views/product.dart';
import 'package:vendas/views/providers/product_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: const CommonAppBar(title: 'Produtos'),
      body: FutureBuilder<List<Product>>(
        future: ProductController().getAll(provider.auth.accessToken),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while waiting for data
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Error: ${snapshot.error}'), // Show error message if fetch fails
            );
          } else {
            final products = snapshot.data;
            return ListView.builder(
              itemCount: products?.length,
              itemBuilder: (context, index) {
                final product = products![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductView(product: product),
                      ),
                    );
                  },
                  child: ProductTile(
                      product: product,
                      acesssToken: provider.auth.accessToken,
                      productProvider: productProvider),
                );
              },
            );
          }
        },
      ),
    );
  }
}
