import 'dart:async';

import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';

class ProductManager {
  final StreamController<List<ProductModel>> _streamController =
      StreamController<List<ProductModel>>();

  get products => _streamController.stream;

  ProductManager() {
    getStreamProducts().listen((event) {
      _streamController.add(event);
    });
  }

  Stream<List<ProductModel>> getStreamProducts() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      yield await ProductService().getProducts();
    }
  }
}
