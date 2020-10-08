import 'package:alla24/colors.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).favoritesProducts;
    return Scaffold(
      appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Alla24Colors.button,
          title: Text('المفضلة')),
      body: Container(
          height: double.infinity,
          padding: EdgeInsets.all(10),
          child: SafeArea(
            top: true,
            bottom: true,
            left: false,
            right: false,
            child: productsData.isEmpty
                ? Center(
                    child: Text('No favorites yet please add an favorites',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w200,
                        )))
                : ProductsGrid(productsData),
          )),
    );
  }
}
