import 'package:flutter/material.dart';

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
    return transaction;
  }

  Future<List<TransactionItemsModel>> getTransactionItemDetail(
      int transactionId) async {
    final result = await supabase
        .from('transactions_item')
        .select<List<Map<String, dynamic>>>('id, products!inner(*)')
        .eq('transactions_id', transactionId);
    final itemDetail = result
        .map(
          (e) => TransactionItemsModel.fromJson(e),
        )
        .toList();
    print(result);
    return itemDetail;
  }
}
