import 'package:alla24/provider/cart_item.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'shopping_cart_controller.g.dart';

class ShoppingCartController = _ShoppingCartControllerBase
    with _$ShoppingCartController;

abstract class _ShoppingCartControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();

  Future init(BuildContext context) async {
    cart = Provider.of<Products>(
      context,
    );
    cartItems = cart.cartItems;
  }

  @observable
  Products cart = Products();
  @observable
  Map<String, CartItem> cartItems = Map();

  @observable
  bool loading = false;

  @observable
  bool isFavorite = false;
}
