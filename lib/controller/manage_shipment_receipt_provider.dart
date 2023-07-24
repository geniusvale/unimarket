import 'package:flutter/material.dart';

import '../models/transaction/transaction_model.dart';
import '../utilities/constants.dart';

class ManageShipmentReceiptProvider extends ChangeNotifier {
  Future<List<TransactionModel>> getAllTransactionIncludeProdukFisik() async {
    final result = await supabase
        .from('transactions')
        .select<List<Map<String, dynamic>>>(
            '*, profiles:users_id(*), address(*), transactions_item(*, products!inner(*, profiles(*)))')
        .neq('ongkir', 0)
        .eq('transactions_item.products.category', 'Produk Fisik');
    print(result);
    final data = result.map((e) => TransactionModel.fromJson(e)).toList();
    return data;
  }
}
