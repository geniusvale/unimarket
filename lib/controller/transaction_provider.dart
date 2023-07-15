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
          'order_status': 'CONFIRMED',
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
      {bool? isConfirmed,
      bool? isCancelled,
      String? status,
      Function()? onPressed}) {
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
          } else if (isCancelled == true) {
            return null;
          } else {
            return onPressed;
          }
        }
      case 'SETTLED':
        {
          if (isConfirmed == true) {
            return null;
          } else if (isCancelled == true) {
            return null;
          } else {
            return onPressed;
          }
        }
      default:
        return null;
    }
  }

  refundButtonState(
      {required bool isCancelled,
      required bool isConfirmed,
      required String paymentStatus,
      required String transactionItemStatus,
      required Function()? onPressed}) {
    //Kalau tidak mau ada return, gunakan break; pada switch case
    switch (paymentStatus) {
      case 'UNPAID':
        null;
        break;
      case 'PENDING':
        {
          null;
          break;
        }
      case 'EXPIRED':
        null;
        break;
      case 'PAID':
        {
          if (isConfirmed == true) {
            return null;
          } else if (isConfirmed == false &&
              transactionItemStatus == 'PENDING') {
            return onPressed;
          } else if (isCancelled == true) {
            return null;
          } else {
            return null;
          }
        }
      case 'SETTLED':
        {
          if (isConfirmed == true) {
            return null;
          } else if (isConfirmed == false &&
              transactionItemStatus == 'PENDING') {
            return onPressed;
          } else if (isCancelled == true) {
            return null;
          } else {
            return null;
          }
        }
      default:
        return null;
    }
  }

  cancelTransactionButtonState({
    required String paymentStatus,
    required Function()? onPressed,
  }) {
    switch (paymentStatus) {
      case 'SETTLED':
        null;
        break;
      case 'PAID':
        null;
        break;
      case 'UNPAID':
        {
          return onPressed;
        }
      case 'PENDING':
        {
          return onPressed;
        }
      case 'EXPIRED':
        null;
        break;
      default:
        return null;
    }
  }

  cancelTransaction({required String invoicesId}) async {
    await xendit.ExpireInvoice(
      invoice_id: invoicesId,
    );
    // await supabase.from('transactions_item').delete({
    //   'isCancelled': true,
    //   'order_status': 'CANCELLED',
    // }).eq('transactions_id', transactionItemId);
  }

  refundTransactionItem(
      {required int transactionItemId, required int productPrice}) async {
    await supabase.from('transactions_item').update({
      'isCancelled': true,
      'status': 'CANCELLED',
    }).eq('id', transactionItemId);

    final currentSaldo = await supabase
        .from('profiles')
        .select('saldo')
        .eq('id', supabase.auth.currentUser!.id)
        .single();
    print(currentSaldo);

    final newSaldo = currentSaldo['saldo'] + productPrice;

    await supabase.from('profiles').update({
      'saldo': newSaldo,
    }).eq('id', supabase.auth.currentUser!.id);
    notifyListeners();
  }
}
