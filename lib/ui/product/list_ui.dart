import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/utils/converter.dart';

class ProductListUI extends StatelessWidget {
  final Future<List<ProductModel>> products;
  final Future<void> Function() onRefresh;

  const ProductListUI(
      {Key? key, required this.products, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FutureBuilder<List<ProductModel>>(
          future: products,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "${snapshot.data![index].id} - ${snapshot.data![index].name}"),
                      subtitle:
                          Text(convertIntToRupiah(snapshot.data![index].price)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () {
                        Navigator.pushNamed(context, '/edit-product',
                            arguments: snapshot.data![index].id);
                      },
                    ),
                  );
                });
          }),
    );
  }
}
