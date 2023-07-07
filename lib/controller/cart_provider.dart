import 'package:flutter/material.dart';
import 'package:unimarket/models/cart/cart_items/cart_items_model.dart';

import '../utilities/constants.dart';

class CartProvider extends ChangeNotifier {
  int? currentCartId;

  Future<bool> checkIfHasCart(BuildContext context) async {
    bool? hasCart;
    //Cek user sudah punya keranjang atau belum
    //Jika belum, add keranjang ke DB Cart
    try {
      final result = await supabase
          .from('cart')
          .select<List<Map>>('users_id')
          .match({'users_id': supabase.auth.currentUser!.id});
      print('hasil cek Cart $result');
      if (result.isEmpty) {
        await supabase
            .from('cart')
            .insert({'users_id': supabase.auth.currentUser!.id});
        hasCart = true;
        notifyListeners();
      } else {
        print('Sudah Punya Cart!');
      }
    } catch (e) {
      print(e);
    }
    return hasCart = true;
  }

  Future<bool> checkIfHasSameCartItems({required int productId}) async {
    final getCartId = await supabase.from('cart').select<List<Map>>('id').match(
      {'users_id': supabase.auth.currentUser!.id},
    );
    print('cekcek $getCartId');
    final cartId = getCartId[0]['id'];
    currentCartId = cartId;
    notifyListeners();
    final result = await supabase
        .from('cart_items')
        .select<List<Map>>('cart_id, product_id')
        .match(
      {
        'cart_id': cartId,
        'product_id': productId,
      },
    );
    print('same cartItem result $result');
    if (result.isEmpty) {
      print('Tidak ada cartItem yang sama');
      return false;
    } else {
      return true;
    }
  }

  addToCart({required String usersId, required int productId}) async {
    //Jika sudah, setiap menambah produk ke keranjang,
    //simpan data ke Table CartItems di DB dengan cartId sebelumnya
    print(currentCartId);
    try {
      await supabase.from('cart_items').insert(
        {
          'cart_id': currentCartId,
          'user_id': usersId,
          'product_id': productId,
        },
      );
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  int jumlahkanSubtotal(List<CartItemsModel> data) {
    int newSubtotal = 0;
    for (var i = 0; i < data.length; i++) {
      int? value = data[i].products!.price;
      newSubtotal += value!;
    }
    // notifyListeners();
    return newSubtotal;
  }

  Future<List<CartItemsModel>> getMyCart() async {
    final result = await supabase
        .from('cart_items')
        .select<List<Map<String, dynamic>>>(
          '*, products!inner(*)',
        ) //Inner Join Langsung Ke ForeignKey Table
        .match({'user_id': supabase.auth.currentUser!.id});
    final data = result.map((e) => CartItemsModel.fromJson(e)).toList();
    // print(result);
    notifyListeners();
    return data;
  }

  deleteCartItems(int cartItemsId) async {
    await supabase.from('cart_items').delete().match({'id': cartItemsId});
    notifyListeners();
  }
}
