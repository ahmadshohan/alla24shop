import 'package:alla24/shared/widgets/single_product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alla24/app_route.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/main/shopping_cart/shopping_cart_controller.dart';
import 'package:alla24/provider/cart_item.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  ShoppingCartController _controller = ShoppingCartController();
  final _searchController = TextEditingController();
  bool isInit = true;
  Products cart;
  Map<String, CartItem> cartItems;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      cart = Provider.of<Products>(
        context,
      );
      cartItems = cart.cartItems;
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildFullAppBar(),
      body: cartItems.isEmpty || cart.totalAmount == 0
          ? Center(
              child: Text('Not found items in your cart please add products !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w200)))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (ctx, index) => SingleProductCart(
                              cartId: cart.cartItems.values.toList()[index].id,
                              productId: cart.cartItems.keys.toList()[index],
                              title:
                                  cart.cartItems.values.toList()[index].title,
                              size: cart.cartItems.values.toList()[index].size,
                              image:
                                  cart.cartItems.values.toList()[index].image,
                              currentPrice: cart.cartItems.values
                                  .toList()[index]
                                  .currentPrice,
                              oldPrice: cart.cartItems.values
                                  .toList()[index]
                                  .oldPrice,
                              isFavorite: cart.cartItems.values
                                  .toList()[index]
                                  .isFavorite,
                              quantity: cart.cartItems.values
                                  .toList()[index]
                                  .quantity,
                            )),
                  ),
                  cartItems.isEmpty || cart.totalAmount == 0
                      ? Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(
                            right: 18,
                            bottom: 15,
                          ),
                          child: FloatingActionButton(
                            child: Icon(Icons.add, size: 30),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoute.mainRoute);
                            },
                          ))
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.white30,
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(children: <Widget>[
                                      Text('المجموع النهائي',
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold)),
                                      Chip(
                                          label: RichText(
                                              text: TextSpan(children: [
                                        TextSpan(
                                            text: '${cart.totalAmount} دع',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ))
                                      ])))
                                    ]))),
                            Expanded(
                              child: SizedBox(
                                  height: 30,
                                  child: RaisedButton(
                                    child: Text("ادفع الأن",
                                        style: TextStyle(fontSize: 13)),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    color: Alla24Colors.button,
                                    textColor: Alla24Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    onPressed: () {},
                                  )),
                            )
                          ]))
                ],
              )),
    );
  }

  _buildFullAppBar() {
    return AppBar(
        backgroundColor: Alla24Colors.button,
        leading: IconButton(
          icon: Icon(
            EvaIcons.menu,
            color: Alla24Colors.white,
          ),
          onPressed: () {},
        ),
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Alla24Colors.white,
            ),
            onPressed: () {},
          )
        ]);
  }

  _buildSearchField() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    controller: _searchController,
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      KeyBoard.close(context);
                      /*todo handle search*/
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(
                          EvaIcons.search,
                          color: Colors.white,
                        ),
                        hintText: "search",
                        hintStyle: TextStyle(color: Colors.blueGrey))),
              ))
        ]));
  }
}
