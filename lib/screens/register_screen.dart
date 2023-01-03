import 'package:flutter/material.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/ui/auth/register_form_ui.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final navigator = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    register(String name, String email, String password) async {
      snackbar.showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
        ),
      );
      await authStore.register(email: email, password: password, name: name);
      snackbar.hideCurrentSnackBar();
      navigator.pushNamedAndRemoveUntil("/", (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Register Account for accessing Product Inventory Apps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterFormUI(
                onSubmitted: register,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
