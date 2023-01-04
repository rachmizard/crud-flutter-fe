// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';

class ProductEditFormUI extends StatefulWidget {
  final ProductModel? product;
  Function({
    String name,
    int price,
    String code,
  }) onSubmit;

  ProductEditFormUI({super.key, this.product, required this.onSubmit});

  @override
  State<ProductEditFormUI> createState() => _ProductEditFormUIState();
}

class _ProductEditFormUIState extends State<ProductEditFormUI> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _codeController.text = widget.product!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: 'Code',
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit(
                          name: _nameController.text,
                          price: int.parse(_priceController.text),
                          code: _codeController.text,
                        );
                      }
                    },
                    child: const Text('Update Product'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
