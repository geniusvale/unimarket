import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class WishlistProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> getWishlist() async {
    try {
      final allWishlist = await supabase
          .from('wishlist')
          .select<List<Map<String, dynamic>>>('*, products(*)');
      print(allWishlist);
      notifyListeners();
      return allWishlist;
      //WORKING GOOD
    } catch (e) {
      rethrow;
    }
  }
}
