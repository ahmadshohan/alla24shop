import 'package:alla24/shared/services/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'shopping_cart_controller.g.dart';

class ShoppingCartController = _ShoppingCartControllerBase
    with _$ShoppingCartController;

abstract class _ShoppingCartControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();

  @observable
  bool loading = false;

  @observable
  bool isFavorite = false;
}
