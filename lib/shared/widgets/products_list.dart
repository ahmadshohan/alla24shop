import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/single_product_horizental.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;
  ProductsList(this.products);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: products[index], child: SingleProductHorizental())),
    );
  }
}
