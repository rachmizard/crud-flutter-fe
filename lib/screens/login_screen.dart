import 'package:flutter/material.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/ui/auth/login_form_ui.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final navigator = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    login(String email, String password) async {
      snackbar.showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
        ),
      );
      await authStore.login(email, password);
      snackbar.hideCurrentSnackBar();
      navigator.pushNamedAndRemoveUntil("/", (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Login to Product Inventory Apps',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginFormUI(
              onSubmitted: login,
            )
          ]),
        ),
      ),
    );
  }
}
