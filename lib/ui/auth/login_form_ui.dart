import 'package:flutter/material.dart';

typedef OnSubmitted = Future<void> Function(String email, String password);

class LoginFormUI extends StatefulWidget {
  final OnSubmitted onSubmitted;
  final bool isLoading;

  const LoginFormUI({
    Key? key,
    required this.onSubmitted,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<LoginFormUI> createState() => _LoginFormUIState();
}

class _LoginFormUIState extends State<LoginFormUI> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              enabled: !widget.isLoading,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }

                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              enabled: !widget.isLoading,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.isLoading) return;

                    if (_formKey.currentState!.validate()) {
                      widget.onSubmitted(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  child: widget.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
