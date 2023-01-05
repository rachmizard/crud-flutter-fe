import 'package:flutter/material.dart';
import 'package:frontend/screens/add_product_screen.dart';
import 'package:frontend/screens/edit_product_screen.dart';
import 'package:frontend/screens/home_screen.dart';

import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => HomeScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/register': (BuildContext context) => const RegisterScreen(),
  '/edit-product': (BuildContext context) => const EditProductScreen(),
  '/add-product': (BuildContext context) => const AddProductScreen(),
};
