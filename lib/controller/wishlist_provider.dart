import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class WishlistProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> getWishlist() async {
    final user = supabase.auth.currentUser;
    try {
      final allWishlist = await supabase
          .from('wishlist')
          .select<List<Map<String, dynamic>>>('*, products!inner(*)')
          .eq('users_id', user?.id);
      // final allWishlist = await supabase
      //     .from('products')
      //     .select<List<dynamic>>('*, wishlist!inner(*)');
      print(allWishlist);
      notifyListeners();
      return allWishlist;
      //WORKING GOOD
    } catch (e) {
      rethrow;
    }
  }
}
