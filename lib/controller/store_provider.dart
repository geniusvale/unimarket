import 'package:flutter/material.dart';

import '../models/transaction/transaction_items_model.dart';
import '../utilities/constants.dart';

class StoreProvider extends ChangeNotifier {
  int tabIndex = 0;

  //WIDGET Menampilkan Dialog Hapus Produk di Toko
  Future<List<TransactionItemsModel>> getMyOrder() async {
    final result = await supabase
        .from('transactions_item')
        .select('*, products!inner(*), profiles:users_id(*)')
        .eq('products.seller_id', supabase.auth.currentUser!.id);
    final data = result
        .map<TransactionItemsModel>((e) => TransactionItemsModel.fromJson(e))
        .toList();
    print(data);
    return data;
  }

  Future<List<Map<String, dynamic>>> getMyOrderJson() async {
    final result = await supabase
        .from('transactions_item')
        .select<List<Map<String, dynamic>>>(
            '*, products!inner(*), profiles:users_id(*)')
        .eq('products.seller_id', supabase.auth.currentUser!.id);
    // final data = result
    //     .map<TransactionItemsModel>((e) => TransactionItemsModel.fromJson(e))
    //     .toList();
    print(result);
    return result;
  }
}
