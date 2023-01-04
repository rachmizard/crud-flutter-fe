import 'package:flutter/material.dart';

typedef OnSubmitted = Future<void> Function(
    String name, String email, String password);

class RegisterFormUI extends StatefulWidget {
  final OnSubmitted onSubmitted;
  final bool isLoading;

  const RegisterFormUI({
    Key? key,
    required this.isLoading,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<RegisterFormUI> createState() => _LoginFormUIState();
}

class _LoginFormUIState extends State<RegisterFormUI> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

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
              enabled: !widget.isLoading,
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }

                if (value.length < 6) {
                  return 'Name must be at least 6 characters long';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: !widget.isLoading,
              controller: _emailController,
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
              enabled: !widget.isLoading,
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.isLoading) return;

                if (_formKey.currentState!.validate()) {
                  widget.onSubmitted(
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text,
                  );
                }
              },
              child: widget.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Register Now'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
