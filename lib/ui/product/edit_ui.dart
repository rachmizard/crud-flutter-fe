import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/ui/product/form_ui.dart';

class ProductDetailUI extends StatelessWidget {
  final int? productId;

  const ProductDetailUI({Key? key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final snackbar = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    Future<void> onSubmit(ProductModel values) async {
      try {
        await productService.updateProduct(
          productId!,
          values,
        );

        snackbar.showSnackBar(
          const SnackBar(
            content: Text('Product updated'),
          ),
        );

        navigator.pop();
      } catch (e) {
        snackbar.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          FutureBuilder<ProductModel>(
              future: productService.getProductById(id: productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                if (snapshot.data == null) {
                  return const Text('Product not found');
                }

                return ProductFormUI(
                  product: snapshot.data,
                  onSubmit: onSubmit,
                );
              })
        ],
      ),
    );
  }
}
