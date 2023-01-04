import 'package:flutter/material.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/stores/profile_store.dart';
import 'package:frontend/ui/auth/login_form_ui.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final profileStore = Provider.of<ProfileStore>(context, listen: false);

    final navigator = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    login(String email, String password) async {
      try {
        setState(() {
          _isLoading = true;
        });

        final loginResponse = await authStore.login(email, password);
        await profileStore.getProfile(loginResponse.token);

        navigator.pushNamedAndRemoveUntil("/", (route) => false);
      } catch (e) {
        snackbar.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
              isLoading: _isLoading,
            )
          ]),
        ),
      ),
    );
  }
}
