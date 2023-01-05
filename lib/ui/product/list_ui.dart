import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/managers/product_manager.dart';
import 'package:frontend/utils/converter.dart';

class ProductListUI extends StatelessWidget {
  const ProductListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
        stream: ProductManager().products,
        initialData: const [],
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text('No data'));
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              break;
          }

          if (snapshot.data?.isEmpty ?? true) {
            return const Center(child: Text('No data'));
          }

          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                ProductModel product = snapshot.data![index];

                return Card(
                  child: ListTile(
                    title: Text("${product.id} - ${product.name}"),
                    subtitle: Text(convertIntToRupiah(product.price)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.pushNamed(context, '/edit-product',
                          arguments: product.id);
                    },
                  ),
                );
              });
        });
  }
}
