import 'package:flutter/material.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/stores/profile_store.dart';
import 'package:frontend/ui/product/list_ui.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final authStore = context.read<AuthStore>();
    final profileStore = context.watch<ProfileStore>();

    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              authStore.logout();
              navigator.pushReplacementNamed('/login');
            },
          ),
        ],
        title: const Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigator.pushNamed('/add-product');
        },
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Welcome back, ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  profileStore.user?.name ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const ProductListUI()
          ],
        ),
      ),
    );
  }
}
