import 'package:flutter/material.dart';
import 'package:unimarket/models/product/product_model.dart';
import 'package:unimarket/screens/product/detail_product.dart';

import '../utilities/constants.dart';

Future<List<ProductModel>> _searchProducts(String keyword) async {
  // Lakukan pencarian produk di Supabase berdasarkan keyword
  final response = await supabase
      .from('products')
      .select<List<Map<String, dynamic>>>('*, profiles:seller_id(*)')
      .textSearch('name', keyword);

  print(response);
  if (response != null) {
    return response.map((e) => ProductModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to search products');
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      title: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder<List<ProductModel>>(
      future: _searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailProduct(index: index, snapshot: snapshot),
                    ),
                  );
                  // close(context, snapshot);
                },
              );
            },
          );
        }
      },
    );
  }
}
