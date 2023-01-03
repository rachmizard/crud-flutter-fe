import 'package:flutter/material.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(authStore.isAuthenticated
                ? 'Welcome ${authStore.token}'
                : 'Home'),
          ],
        ),
      ),
    );
  }
}
