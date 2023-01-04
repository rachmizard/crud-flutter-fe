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
    return Expanded(
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

              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name.toString()),
                        subtitle: Text(
                            convertIntToRupiah(snapshot.data![index].price)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {},
                      );
                    }),
              );
            }));
  }
}
