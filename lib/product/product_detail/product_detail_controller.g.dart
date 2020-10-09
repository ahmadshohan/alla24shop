// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductDetailController on _ProductDetailControllerBase, Store {
  final _$loadingAtom = Atom(name: '_ProductDetailControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$isFavoriteAtom =
      Atom(name: '_ProductDetailControllerBase.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  final _$sizeAtom = Atom(name: '_ProductDetailControllerBase.size');

  @override
  String get size {
    _$sizeAtom.reportRead();
    return super.size;
  }

  @override
  set size(String value) {
    _$sizeAtom.reportWrite(value, super.size, () {
      super.size = value;
    });
  }

  final _$quantityAtom = Atom(name: '_ProductDetailControllerBase.quantity');

  @override
  int get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(int value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  final _$_ProductDetailControllerBaseActionController =
      ActionController(name: '_ProductDetailControllerBase');

  @override
  void selectedSize(String selectedSize) {
    final _$actionInfo = _$_ProductDetailControllerBaseActionController
        .startAction(name: '_ProductDetailControllerBase.selectedSize');
    try {
      return super.selectedSize(selectedSize);
    } finally {
      _$_ProductDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectedQuantity(int selectedQuantity) {
    final _$actionInfo = _$_ProductDetailControllerBaseActionController
        .startAction(name: '_ProductDetailControllerBase.selectedQuantity');
    try {
      return super.selectedQuantity(selectedQuantity);
    } finally {
      _$_ProductDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
isFavorite: ${isFavorite},
size: ${size},
quantity: ${quantity}
    ''';
  }
}
