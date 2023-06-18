import 'package:flutter/material.dart';

import '../models/product/product_model.dart';
import '../utilities/constants.dart';

class WishlistProvider extends ChangeNotifier {
  Future<List<ProductModel>> getWishlist() async {
    final user = supabase.auth.currentUser;
    try {
      final allWishlistList = await supabase
          .from('wishlist')
          .select('products_id, products!inner(*)')
          .eq('users_id', user?.id);
      final allWishlist = allWishlistList
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();
      print(allWishlist);
      notifyListeners();
      return allWishlist;
      //WORKING GOOD
    } catch (e) {
      rethrow;
    }
  }
}
