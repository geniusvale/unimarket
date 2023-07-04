import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class TransactionProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> getTransaction() async {
    final result = await supabase
        .from('transactions')
        .select<List<Map<String, dynamic>>>()
        .eq('users_id', supabase.auth.currentUser!.id);
    return result;
  }

  Future<List<Map<String, dynamic>>> getTransactionItemDetail(
      int transactionId) async {
    final result = await supabase
        .from('transactions_item')
        .select<List<Map<String, dynamic>>>(
            'transactions_id, products!inner(*)')
        .eq('transactions_id', transactionId);
    print(result);
    return result;
  }
}
