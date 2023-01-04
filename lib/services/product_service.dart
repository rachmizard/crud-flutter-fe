import 'dart:convert';

import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/request_adapter_service.dart';
import 'package:frontend/utils/base_response.dart';

class ProductService extends RequestAdapterService {
  Future<List<ProductModel>> getProducts() async {
    final response = await sendGetRequest('/api/products');

    if (response.statusCode != 200) {
      return BaseResponse.fromJson(jsonDecode(response.body)).data ?? [];
    }

    final data = jsonDecode(response.body)['data'] as List;
    final products = data.map((e) => ProductModel.fromJson(e)).toList();

    return products;
  }

  Future<ProductModel> getProductById(String id) async {
    final response = await sendGetRequest('/api/products/$id');

    if (response.statusCode != 200) {
      return BaseResponse.fromJson(jsonDecode(response.body)).data ??
          ProductModel(
            code: '',
            name: '',
            price: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            id: 0,
          );
    }

    final data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
    final product = ProductModel.fromJson(data);

    return product;
  }
}
