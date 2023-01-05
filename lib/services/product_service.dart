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

  Future<ProductModel> getProductById({int? id}) async {
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

  Future<void> createProduct(ProductModel product) async {
    await sendPostRequest(
      '/api/products',
      body: {
        'name': product.name.toString(),
        'price': product.price.toString(),
        'code': product.code.toString(),
      },
    );

    // print("Response: ${response.body}");

    // if (response.statusCode != 200) {
    //   return Future.error(jsonDecode(response.body)['message'].toString());
    // }
  }

  Future<void> updateProduct(id, ProductModel payload) async {
    var body = {
      'name': payload.name.toString(),
      'price': payload.price.toString(),
      'code': payload.code.toString(),
    };

    final response = await sendPutRequest('/api/products/$id', body: body);

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
  }

  Future<void> deleteProduct(id) async {
    try {
      await sendDeleteRequest('/api/products/$id');
    } catch (e) {
      rethrow;
    }
  }
}
