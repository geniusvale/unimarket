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
}
