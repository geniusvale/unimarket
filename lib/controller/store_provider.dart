import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction/transaction_items_model.dart';
import '../screens/cart/xendit_webview.dart';
import '../utilities/constants.dart';

class StoreProvider extends ChangeNotifier {
  int tabIndex = 0;

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

  withdraw(
      {required BuildContext context,
      required String username,
      required int amount}) async {
    final dateTime = DateTime.now();
    final String formattedDateTime = DateFormat.yMd().format(dateTime);
    int randomId = Random().nextInt(100);

    final payout = await xendit.createPayOutLink(
        external_id: 'WD-$randomId/$username/$formattedDateTime',
        amount: amount,
        email: supabase.auth.currentUser!.email!);
    print(payout);

    await supabase.from('withdraw').insert({
      'users_id': supabase.auth.currentUser!.id,
      'payout_id': payout['id'],
      'payout_url': payout['payout_url'],
      'external_id': payout['external_id'],
      'amount': payout['amount'],
      'status': payout['status'],
      'expiration_timestamp': payout['expiration_timestamp'],
    });

    await supabase.from('profiles').update({
      'saldo': 0,
    }).eq('id', supabase.auth.currentUser!.id);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => XenditWebview(url: payout['payout_url']),
      ),
    );
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getWithdrawHistory() async {
    // final newInfo = await xendit.getPayOutLink(id: payoutId);
    // await supabase.from('withdraw').update({
    //   'status': newInfo['status'],
    // });

    final res = await supabase
        .from('withdraw')
        .select<List<Map<String, dynamic>>>('*')
        .eq('users_id', supabase.auth.currentUser!.id);
    // print(res);
    return res;
  }
}
