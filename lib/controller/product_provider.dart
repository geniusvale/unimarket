import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product/product_model.dart';
import '../utilities/constants.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? allProducts; //Masuh Kosong, harus ada operasi add
  List<ProductModel>? allMyProducts; //Masuh Kosong, harus ada operasi add
  ProductModel? productData; //Masuh Kosong, harus ada operasi add

  //Tambah Produk Ke DB
  void addProduct({String? name, desc, category, userId, int? price}) async {
    await supabase.from('products').insert(
      {
        'name': name,
        'price': price,
        'desc': desc,
        'category': category,
        'seller_id': userId
      },
    );
    notifyListeners();
    //WORKING GOOD
  }

  //Menampilkan Seluruh Produk Dari Tabel di DB
  Future<List<ProductModel>> getProduct() async {
    final supabase = Supabase.instance.client;
    final result = await supabase.from('products').select();
    final allProducts = result
        .map<ProductModel>(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
    notifyListeners();
    return allProducts;
    //WORKING GOOD
  }

  //Menampilkan Seluruh Produk Dari Toko Saya
  Future<List<ProductModel>> getMyStoreProduct() async {
    final supabase = Supabase.instance.client;
    final result = await supabase
        .from('products')
        .select()
        .eq('seller_id', supabase.auth.currentUser!.id);
    final semuaProdukSaya = result
        .map<ProductModel>(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
    // allMyProducts?.add(semuaProduk);
    notifyListeners();
    return semuaProdukSaya;
    //WORKING GOOD
  }

  //Hapus Produk
  deleteProduct(int productId) async {
    await supabase.from('products').delete().match({'id': productId});
    notifyListeners();
    //WORKING GOOD
  }

  showDeleteProduct(BuildContext context, AsyncSnapshot snapshot, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                ProductsProvider().deleteProduct(
                  snapshot.data?[index]['id'] ?? 0,
                );
                Navigator.pop(context);
                // setState(() {});
              },
              child: const Text('Oke'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  //Edit Produk
  editProduct({
    String? name,
    desc,
    int? price,
    String? currentName,
    currentDesc,
    currentPrice,
    currentCategory,
  }) async {
    await supabase.from('products').update({
      'name': name,
      'price': price,
      'desc': desc,
      'category': currentCategory,
    }).match({
      'name': currentName,
      'price': currentPrice,
      'desc': currentDesc,
      'category': currentCategory,
    });
    notifyListeners();
    //WORKING GOOD
  }

  addToWishlist({String? usersId, int? productId}) async {
    try {
      await supabase.from('wishlist').insert({
        'users_id': usersId,
        'products_id': productId,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
