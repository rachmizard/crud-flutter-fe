import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/ui/product/form_ui.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    var snackbar = ScaffoldMessenger.of(context);
    var productService = ProductService();

    onSubmit(ProductModel values) async {
      try {
        await productService.createProduct(
          ProductModel(
            name: values.name,
            price: values.price,
            code: values.code,
          ),
        );

        snackbar.showSnackBar(
          const SnackBar(
            content: Text("Product added"),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ProductFormUI(
              onSubmit: onSubmit,
              submitLabel: "Add",
            ),
          ],
        ),
      ),
    );
  }
}
