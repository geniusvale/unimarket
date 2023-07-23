import 'package:flutter/material.dart';

import '../models/product/product_model.dart';
import '../utilities/constants.dart';

class WishlistProvider extends ChangeNotifier {
  Future<List<ProductModel>> getWishlist() async {
    final user = supabase.auth.currentUser;
    try {
      final result = await supabase
          .from('wishlist')
          .select(
              'products!inner(*, profiles:seller_id(*))') //Inner Join Langsung Ke ForeignKey Table
          .eq('users_id', user?.id);
      final allWishlist = result
          .map<ProductModel>((e) => ProductModel.fromJson(e['products']))
          .toList();
      // print(result);
      notifyListeners();
      return allWishlist;
      //WORKING GOOD
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkIfHasSameWishlistItems({required int productId}) async {
    final result = await supabase
        .from('wishlist')
        .select<List<Map>>('users_id, products_id')
        .match(
      {
        'users_id': supabase.auth.currentUser!.id,
        'products_id': productId,
      },
    );
    print('same wishlistItem result $result');
    if (result.isEmpty) {
      print('Tidak ada wishlistItem yang sama');
      return false;
    } else {
      return true;
    }
  }

  //Hapus Wishlist
  deleteWishlist({
    required int productId,
  }) async {
    await supabase.from('wishlist').delete().match({
      'products_id': productId,
      'users_id': supabase.auth.currentUser!.id,
    });
    notifyListeners();
    //WORKING GOOD
  }

  showDeleteProduct(BuildContext context,
      AsyncSnapshot<List<ProductModel>> snapshot, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      loadingIndicator,
                );
                await WishlistProvider().deleteWishlist(
                  productId: snapshot.data![index].id ?? 0,
                );
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pop(context);
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
}
