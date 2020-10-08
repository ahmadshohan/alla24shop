import 'package:alla24/app_route.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleProduct = Provider.of<Product>(context);
    final product = Provider.of<Products>(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoute.productDetailRoute,
          arguments: singleProduct.id),
      child: Container(
          child: Card(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Card(
                        elevation: 5,
                        color: Alla24Colors.cardItemBg,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  icon: Icon(
                                      singleProduct.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: singleProduct.isFavorite
                                          ? Colors.red
                                          : Colors.black),
                                  onPressed: () =>
                                      singleProduct.toggleFavoriteStatus()),
                              Expanded(
                                  child: Row(children: [
                                Expanded(
                                    child: Image.asset(
                                  singleProduct.image,
                                  fit: BoxFit.contain,
                                ))
                              ])),
                            ]))),
                Text('حقيبة ظهر'),
                Row(children: [
                  Expanded(
                    child: Text(
                      "${singleProduct.currentPrice.toString()} دع",
                      style:
                          TextStyle(fontSize: 14, color: Alla24Colors.button),
                      // fontSize: product.isSelected ? 18 : 16,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      singleProduct.oldPrice.toString(),
                      style: TextStyle(
                          fontSize: 9, decoration: TextDecoration.lineThrough),
                    ),
                  )
                ]),
                Row(children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: RaisedButton(
                        child: Text(
                          "اشتري الآن",
                          style: TextStyle(fontSize: 13),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        color: Alla24Colors.button,
                        textColor: Alla24Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'خصم %8',
                      style:
                          TextStyle(fontSize: 12, color: Alla24Colors.button),
                    ),
                  )
                ]),
              ]),
        ),
      )),
    );
  }
}
