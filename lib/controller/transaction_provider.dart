import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/utilities/utilities.dart';

import '../models/transaction/transaction_items_model.dart';
import '../models/transaction/transaction_model.dart';
import '../utilities/constants.dart';

class TransactionProvider extends ChangeNotifier {
  Future<List<TransactionModel>> getTransaction() async {
    final result = await supabase
        .from('transactions')
        .select<List<Map<String, dynamic>>>()
        .eq('users_id', supabase.auth.currentUser!.id);
    final transaction =
        result.map((e) => TransactionModel.fromJson(e)).toList();
    //UPDATE STATUS DARI XENDIT
    for (var transactionData in transaction) {
      final res = await xendit.getInvoice(
        invoice_id: transactionData.invoicesId!,
      );
      // print(res);
      await supabase.from('transactions').update({
        'status': res['status'],
      }).match({
        'id': transactionData.id,
      });
    }
    notifyListeners();
    return transaction;
  }

  Future<List<TransactionItemsModel>> getTransactionItemDetail(
      int transactionId) async {
    try {
      final result = await supabase
          .from('transactions_item')
          .select<List<Map<String, dynamic>>>(
              '*, products:products_id(*, profiles:seller_id(*)) ')
          .eq('transactions_id', transactionId);
      final itemDetail = result
          .map(
            (e) => TransactionItemsModel.fromJson(e),
          )
          .toList();
      print(result);
      notifyListeners();
      return itemDetail;
    } on PostgrestException catch (_) {
      rethrow;
    }
  }

  confirmTransaction(
      {required int transactionItemId,
      productPrice,
      required String sellerId,
      required int productId,
      required String productCategory,
      String? fileName}) async {
    //Jika Produk Digital, Ada Proses Download!
    //Proses unduh disini ->
    //.........................................
    //Selain itu Langsung Ubah Status Saja!
    if (productCategory == 'Produk Digital') {
      try {
        final Uint8List file = await supabase.storage
            .from('product-files')
            .download('$sellerId/$productId/${fileName!.split('/').last}');
        var downloadedFile = await writeFile(file, fileName.split('/').last);

        //Ubah Status Menjadi isConfirmed
        await supabase.from('transactions_item').update({
          'isConfirmed': true,
        }).match({
          'id': transactionItemId,
        });
        //Masukkan Saldo Ke Penjual
        await supabase.from('profiles').update({
          'saldo': productPrice,
        }).eq('id', sellerId);
      } catch (e) {
        rethrow;
      }
    } else {
      //Ubah Status Menjadi isConfirmed
      await supabase.from('transactions_item').update({
        'isConfirmed': true,
      }).match({
        'id': transactionItemId,
      });
      //Masukkan Saldo Ke Penjual
      await supabase.from('profiles').update({
        'saldo': productPrice,
      }).eq('id', sellerId);
    }
    //Setelah isConfirmed Tombol Disabled!
    notifyListeners();
  }

  buttonConfirmedState(
      {bool? isConfirmed, String? status, Function()? onPressed}) {
    //Kalau tidak mau ada return, gunakan break; pada switch case
    switch (status) {
      case 'UNPAID':
        null;
        break;
      case 'PENDING':
        null;
        break;
      case 'EXPIRED':
        null;
        break;
      case 'PAID':
        {
          if (isConfirmed == true) {
            return null;
          } else {
            return onPressed;
          }
        }
      case 'SETTLED':
        {
          if (isConfirmed == true) {
            return null;
          } else {
            return onPressed;
          }
        }
      default:
        return null;
    }
  }

  cancelButtonState(
      {bool? isCancelled,
      bool? isConfirmed,
      bool? isDisabled,
      String? status,
      Function()? onPressed}) {
    //Kalau tidak mau ada return, gunakan break; pada switch case
    switch (status) {
      case 'UNPAID':
        return onPressed;
      case 'PENDING':
        return onPressed;
      case 'EXPIRED':
        null;
        break;
      case 'PAID':
        {
          if (isConfirmed == true) {
            return null;
          } else if (isConfirmed == false) {
            return onPressed;
          } else {
            return null;
          }
        }
      case 'SETTLED':
        {
          if (isConfirmed == true) {
            return null;
          } else {
            return null;
          }
        }
      default:
        return null;
    }
  }

  // cancelTransaction(int transactionItemId, int productPrice) async {
  //   await supabase.from('transactions_item').delete({
  //     'isCancelled': true,
  //     'order_status': 'CANCELLED',
  //   }).eq('transactions_id', transactionItemId);
  // }

  refundTransactionItem(int transactionItemId, int productPrice) async {
    await supabase.from('transactions_item').update({
      'isCancelled': true,
      'order_status': 'CANCELLED',
    }).eq('transactions_id', transactionItemId);

    await supabase.from('profiles').update({
      'saldo': productPrice,
    }).eq('id', supabase.auth.currentUser!.id);
    notifyListeners();
  }
}
