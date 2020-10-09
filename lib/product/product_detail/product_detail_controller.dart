import 'package:alla24/shared/services/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'product_detail_controller.g.dart';

class ProductDetailController = _ProductDetailControllerBase
    with _$ProductDetailController;

abstract class _ProductDetailControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();

  Future init() async {
    size = 'small';
    quantity = 1;
  }

  @observable
  bool loading = false;

  @observable
  bool isFavorite = false;

  @observable
  String size = 'small';

  @observable
  int quantity = 1;

  @action
  void selectedSize(String selectedSize) {
    size = selectedSize;
  }

  @action
  void selectedQuantity(int selectedQuantity) {
    quantity = selectedQuantity;
  }
}
