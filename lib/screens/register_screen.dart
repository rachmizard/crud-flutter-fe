import 'package:flutter/material.dart';
import 'package:frontend/stores/auth_store.dart';
import 'package:frontend/stores/profile_store.dart';
import 'package:frontend/ui/auth/register_form_ui.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final profileStore = Provider.of<ProfileStore>(context, listen: false);

    final navigator = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    register(String name, String email, String password) async {
      try {
        setState(() {
          _isLoading = true;
        });

        final registerResponse = await authStore.register(
            email: email, password: password, name: name);

        await profileStore.getProfile(registerResponse.token);

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
        title: const Text('Register'),
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
                isLoading: _isLoading,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
