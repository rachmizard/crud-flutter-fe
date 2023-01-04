import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/stores/profile_store.dart';
import 'package:frontend/ui/product/list_ui.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productService = ProductService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authStore = context.read<AuthStore>();
    final profileStore = context.watch<ProfileStore>();

    final snackbar = ScaffoldMessenger.of(context);

    final navigator = Navigator.of(context);

    Future<List<ProductModel>> fetchProducts() async {
      try {
        return await productService.getProducts();
      } catch (e) {
        snackbar.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
        return [];
      }
    }

    Widget header() {
      return Column(children: [
        Row(
          children: [
            const Text(
              'Welcome back, ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              profileStore.user?.name ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ]);
    }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            ProductListUI(
              onRefresh: fetchProducts,
              products: fetchProducts(),
            )
          ],
        ),
      ),
    );
  }
}
