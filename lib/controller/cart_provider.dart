import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimarket/models/cart/cart_items/cart_items_model.dart';
import 'package:unimarket/screens/cart/xendit_webview.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/profile/profile_model.dart';
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

  makeOrderAndPay(
      {required BuildContext context,
      required List<CartItemsModel> snapshotData,
      required ProfileModel userData,
      required int subtotal}) async {
    //Make new transactions to db
    await supabase.from('transactions').insert({
      'users_id': supabase.auth.currentUser!.id,
      'address': userData.address,
      'phone': userData.phone,
      'email': supabase.auth.currentUser!.email,
      'total_price': subtotal,
      'payment_url': '',
      'quantity': snapshotData.length,
      'status': 'UNPAID',
    });
    //informasi alamat nomor telepon dll lengkapi dihalaman edit profil.
    //redirect ke halaman tsb.
    //GET Transactions ID yang baru dibuat.
    //~~~~~
    final dateTime = DateTime.now();
    final String formattedDateTime = DateFormat.yMd().format(dateTime);
    final transactionId = await supabase
        .from('transactions')
        .select('id, created_at')
        .eq('users_id', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false)
        .limit(1)
        .single();
    //Sudah benar
    print('GET TransactionID $transactionId');
    //ADD every items to transactionItems in db using looping
    for (var cartItems in snapshotData) {
      //Karena perulangan maka yang dikirim JSON, jadi value harus string dahulu!
      print(cartItems);
      await supabase.from('transactions_item').insert({
        'users_id': supabase.auth.currentUser!.id,
        'products_id': '${cartItems.product_id}',
        'transactions_id': '${transactionId['id']}',
      });
    }
    //After adding, delete every cartItems in DB!
    for (var delCartItems in snapshotData) {
      await supabase.from('cart_items').delete().match({
        'id': delCartItems.id,
      });
      print(delCartItems);
    }
    //PAY WITH XENDIT
    var res = await xendit.invoke(
      endpoint: 'POST https://api.xendit.co/v2/invoices',
      headers: {'for-user-id': ''},
      parameters: {
        'external_id': 'INV-${transactionId['id']}-${userData.username}-$formattedDateTime',
        'amount': subtotal,
        'payer_email': supabase.auth.currentUser!.email,
        'description': "Invoice #123"
      },
    );
    print(res);
    final paymentUrl = res['invoice_url'];
    print('Hasil PAYMENT URL $paymentUrl');

    //Tambahkan Invoice ID ke Transactions (Belum diimplement)

    await supabase.from('transactions').update({
      'payment_url': paymentUrl,
      'invoices_id': res['id'],
      'external_id' : res['external_id'],
    }).eq(
      'id',
      '${transactionId['id']}',
    );

    //LAUNCH TO WEBVIEW
    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => XenditWebview(url: paymentUrl),
        ),
      );
      // await launchUrlString(
      //   paymentUrl,
      //   mode: LaunchMode.inAppWebView, //enables WebView
      //   webViewConfiguration: const WebViewConfiguration(
      //     enableJavaScript: true,
      //   ),
      // );
    } catch (e) {
      rethrow;
    }
    //Kembali ke halaman dan refresh dari webview???
    //Mengatur Callback???
  }
}
