import 'package:flutter/material.dart';

import '../models/product/product_model.dart';
import '../utilities/constants.dart';

class WishlistProvider extends ChangeNotifier {
  Future<List<ProductModel>> getWishlist() async {
    final user = supabase.auth.currentUser;
    try {
      final result = await supabase
          .from('wishlist')
          .select('products!inner(*)') //Inner Join Langsung Ke ForeignKey Table
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
}
