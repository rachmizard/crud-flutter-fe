import 'package:flutter/material.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/stores/profile_store.dart';
import 'package:frontend/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthStore(),
        ),
        ChangeNotifierProvider(create: ((context) => ProfileStore()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final initialRoute = authStore.isAuthenticated ? '/' : '/login';

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: initialRoute,
    );
  }
}
