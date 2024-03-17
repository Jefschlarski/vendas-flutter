import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas/models/product.dart';
import 'package:vendas/utils/formater.dart';
import 'package:vendas/views/providers/product_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final String acesssToken;
  final ProductProvider productProvider;
  const ProductTile({
    super.key,
    required this.product,
    required this.acesssToken,
    required this.productProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Formarter.formatarParaReais(product.price),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () async {
                await productProvider.toggleFavorite(
                    acesssToken, product.id, product.favorite);
              },
              icon: product.favorite != null
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border_outlined),
            )),
      ],
    );
  }
}
