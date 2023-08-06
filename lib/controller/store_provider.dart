import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction/transaction_model.dart';
import '../models/withdraw/withdraw_model.dart';
import '../screens/cart/xendit_webview.dart';
import '../utilities/constants.dart';

class StoreProvider extends ChangeNotifier {
  int tabIndex = 0;

  Future<List<TransactionModel>> getMyOrder() async {
    final result = await supabase
        .from('transactions')
        .select<List<Map<String, dynamic>>>(
            '*, profiles:users_id(*), address(*), transactions_item!inner(*, products!inner(*, profiles(*)))')
        .eq(
          'transactions_item.products.seller_id',
          supabase.auth.currentUser!.id,
        );
    final data = result
        .map<TransactionModel>((e) => TransactionModel.fromJson(e))
        .toList();
    print(data);
    return data;
  }

  withdraw({
    required BuildContext context,
    required String username,
    required int amount,
    required bool isSeller,
  }) async {
    final dateTime = DateTime.now();
    final String formattedDateTime = DateFormat.yMd().format(dateTime);
    int randomId = Random().nextInt(100);
    //Buat req api payout ke xendit
    final payout = await xendit.createPayOutLink(
        external_id: isSeller == true
            ? 'WD-$randomId/$username/$formattedDateTime'
            : 'REFUND-$randomId/$username/$formattedDateTime',
        amount: amount,
        email: supabase.auth.currentUser!.email!);
    print(payout);
    //update data dari response xendit ke tabel
    await supabase.from('withdraw').insert({
      'users_id': supabase.auth.currentUser!.id,
      'payout_id': payout['id'],
      'payout_url': payout['payout_url'],
      'external_id': payout['external_id'],
      'amount': payout['amount'],
      'status': payout['status'],
      'expiration_timestamp': payout['expiration_timestamp'],
    });
    //setelah membuat penarikan, buat data saldo menjadi 0 di DB
    await supabase.from('profiles').update({
      'saldo': 0,
    }).eq('id', supabase.auth.currentUser!.id);
    //buka link payout ke webview
    //Harus ada kontrol OnWillPop untuk refresh getPayoutLinkById lalu update status lagi ke table
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => XenditWebview(url: payout['payout_url']),
      ),
    );
    notifyListeners();
  }

  Future<List<WithdrawModel>> getWithdrawHistory() async {
    final res = await supabase
        .from('withdraw')
        .select<List<Map<String, dynamic>>>('*')
        .eq('users_id', supabase.auth.currentUser!.id);
    // print(res);
    final data = res.map((e) => WithdrawModel.fromJson(e)).toList();

    for (var withdraw in data) {
      try {
        final newInfo = await xendit.getPayOutLink(id: withdraw.payout_id!);
        // print(newInfo);
        await supabase.from('withdraw').update({
          'status': newInfo['status'],
        }).eq('id', withdraw.id);
      } catch (e) {
        print(e.toString());
      }
    }
    notifyListeners();
    return data;
  }
}
