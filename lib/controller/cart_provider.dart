import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CartProvider extends ChangeNotifier {
  //Cek user sudah punya keranjang atau belum
  Future<bool> checkIfHasCart() async {
    final result = await supabase
        .from('cart')
        .select('users_id')
        .match({'users_id': supabase.auth.currentUser!.id}).single();
    if (result == null) {
      return false;
    } else {
      return true;
    }
  }

  addToCart(String usersId, totalPrice, quantity, int productId) async {
    //Jika belum, add keranjang ke DB Cart
    final checkCart = await checkIfHasCart();
    if (checkCart == false) {
      supabase.from('cart').insert({'users_id': usersId});
    } else {
      //Jika sudah, setiap menambah produk ke keranjang, simpan data ke Table CartItems di DB dengan cartId sebelumnya
      final getCartId = await supabase.from('cart').select('id').match(
        {'users_id': supabase.auth.currentUser!.id},
      ).single();
      int cartId = getCartId['id'];
      final addToCartItems = await supabase.from('cart_items').insert(
        {
          'cart_id': cartId,
          'user_id': usersId,
          'product_id': productId,
          'quantity': quantity,
        },
      );
    }
  }

  Future<List<Map<String, dynamic>>> getMyCart() async {
    final result = await supabase
        .from('cart_items')
        .select<List<Map<String, dynamic>>>(
            '*, products!inner(*)') //Inner Join Langsung Ke ForeignKey Table
        .match(
      {'user_id': supabase.auth.currentUser!.id},
    );
    print(result);
    return result;
  }
}
