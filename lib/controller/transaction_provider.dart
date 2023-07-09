import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      print(res);
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
              'id, products:products_id(*, profiles:seller_id(*)) ')
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
}
