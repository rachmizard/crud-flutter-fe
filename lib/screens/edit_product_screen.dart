import 'package:flutter/material.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/ui/product/edit_ui.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get id arguments
    final id = ModalRoute.of(context)!.settings.arguments as int;
    var navigator = Navigator.of(context);
    var snackbar = ScaffoldMessenger.of(context);

    var productService = ProductService();

    onDelete() async {
      try {
        await productService.deleteProduct(id);
        snackbar.showSnackBar(
          const SnackBar(
            content: Text('Product deleted'),
          ),
        );
      } catch (e) {
        snackbar.showSnackBar(
          const SnackBar(
            content: Text('Failed to delete product'),
          ),
        );
      } finally {
        navigator.pop();
      }
    }

    confirmDelete() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Product'),
            content: const Text('Are you sure want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onDelete,
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Product',
            onPressed: () {
              confirmDelete();
            },
          ),
        ],
      ),
      body: ProductDetailUI(productId: id),
    );
  }
}
