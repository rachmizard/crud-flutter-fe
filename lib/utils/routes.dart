import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';

import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const HomeScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/register': (BuildContext context) => const RegisterScreen(),
};
