import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimarket/models/cart/cart_items/cart_items_model.dart';
import 'package:unimarket/models/courier/courier_model.dart';
import 'package:unimarket/screens/cart/xendit_webview.dart';

import '../models/profile/profile_model.dart';
import '../utilities/constants.dart';

class CartProvider extends ChangeNotifier {
  int? currentCartId;
  List<CartItemsModel>? data = [];
  // int newSubtotal = cartProvider.jumlahkanSubtotal(data);
  // subtotal = newSubtotal;
  List<CartItemsModel> filteredCartItemData = [];

  int currentOngkirVal = 0;
  String? currentShipmentService;
  CourierModel? currentCourierData;

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

  Future<bool> checkIfHasSameCartItems({
    required int productId,
    String? sellerId,
    String? productCategory,
    required BuildContext context,
  }) async {
    //Mengambil CartID
    final getCartId = await supabase.from('cart').select<List<Map>>('id').match(
      {'users_id': supabase.auth.currentUser!.id},
    );
    print('CART ID $getCartId');
    final cartId = getCartId[0]['id'];
    currentCartId = cartId;
    notifyListeners();
    //MENGAMBIL ITEM DUPLIKAT
    final result = await supabase
        .from('cart_items')
        .select<List<Map>>('*, cart_id, product_id')
        .match(
      {
        'cart_id': cartId,
        'product_id': productId,
      },
    );

    print('same cartItem result $result');
    //Kalau Gak Ada Yang Sama dan Bukan Produk Fisik
    if (result.isEmpty) {
      print('Tidak ada Item yang sama');
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkAlreadyProdukFisikInCart(
      {int? cartId, String? productCategory, String? sellerId}) async {
    //Mengambil CartID
    final getCartId = await supabase.from('cart').select<List<Map>>('id').match(
      {'users_id': supabase.auth.currentUser!.id},
    );
    final cartId = getCartId[0]['id'];
    notifyListeners();
    //MENGAMBIL APAKAH SUDAH ADA PRODUK FISIK DI CART
    final anyProdukFisikInCart = await supabase
        .from('cart_items')
        .select<List<Map>>(
          'cart_id, product_id, products:product_id(category, seller_id)',
        )
        .match({
      'cart_id': cartId,
      'products.category': productCategory,
    });
    if (anyProdukFisikInCart.first['products']['seller_id'] != sellerId &&
        productCategory == 'Produk Fisik') {
      return true;
    } else {
      return false;
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

  int jumlahkanBeratGram(List<CartItemsModel> data) {
    int newTotalGram = 0;
    for (var i = 0; i < data.length; i++) {
      if (data[i].products!.category == 'Produk Fisik') {
        int? value = data[i].products!.weight;
        newTotalGram += value!;
      }
    }
    // notifyListeners();
    return newTotalGram;
  }

  Future<List<CartItemsModel>> getMyCart() async {
    final result = await supabase
        .from('cart_items')
        .select<List<Map<String, dynamic>>>(
          '*, products:product_id(*, profiles:seller_id(*, address:address_id(*)))',
        ) //Inner Join Langsung Ke ForeignKey Table
        .match({'user_id': supabase.auth.currentUser!.id});
    final item = result.map((e) => CartItemsModel.fromJson(e)).toList();
    // print(result);
    data!.addAll(item);
    notifyListeners();
    return item;
  }

  deleteCartItems(int cartItemsId) async {
    await supabase.from('cart_items').delete().match({'id': cartItemsId});
    notifyListeners();
  }

  makeOrderAndPay({
    required BuildContext context,
    required List<CartItemsModel> snapshotData,
    required ProfileModel userData,
    required int subtotal,
    required int ongkir,
    String? shippingInfo,
  }) async {
    //Make new transactions to db
    await supabase.from('transactions').insert({
      'users_id': supabase.auth.currentUser!.id,
      'address_id': userData.address!.id,
      'phone': userData.phone,
      'email': supabase.auth.currentUser!.email,
      'total_price': subtotal,
      'payment_url': '',
      'quantity': snapshotData.length,
      'ongkir': ongkir,
      'shipping_info': shippingInfo,
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
        'external_id':
            'INV-${transactionId['id']}-${userData.username}-$formattedDateTime',
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
      'external_id': res['external_id'],
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
    } catch (e) {
      rethrow;
    }
    //Kembali ke halaman dan refresh dari webview???
    //Mengatur Callback???
  }

  hitungOngkir(
      {BuildContext? context,
      String? originId,
      String? destinationId,
      String? gram,
      String? kurir}) async {
    try {
      final response = await Dio().post(
        "https://api.rajaongkir.com/starter/cost",
        data: {
          'origin': originId,
          'destination': destinationId,
          'weight': gram,
          'courier': kurir,
        },
        options: Options(
          headers: {'key': rajaOngkirKey},
          contentType: 'application/x-www-form-urlencoded',
        ),
      );
      final list = response.data['rajaongkir']['results'] as List<dynamic>;
      List<CourierModel> listAllCourierInfo =
          list.map((e) => CourierModel.fromJson(e)).toList();
      CourierModel courier = listAllCourierInfo[0];
      int ongkirValue = 0;
      await showModalBottomSheet(
        context: context!,
        builder: (ctx) {
          return ListView.builder(
            itemCount: courier.costs!.length,
            itemBuilder: (ctx2, index) => ListTile(
              onTap: () {
                ongkirValue = courier.costs![index].cost![0].value!;
                currentShipmentService = currentCourierData!.name! +
                    courier.costs![index].description! +
                    courier.costs![index].service!;
                Navigator.of(context).pop();
              },
              title: Text('${courier.costs![index].description}'),
              subtitle: Text('${courier.costs![index].service}'),
              trailing: Text(
                numberCurrency.format(courier.costs![index].cost![0].value),
              ),
            ),
          );
        },
      );
      print('Ongkir Value : $ongkirValue');
      currentOngkirVal = ongkirValue;
      notifyListeners();
      // return ongkirValue;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
