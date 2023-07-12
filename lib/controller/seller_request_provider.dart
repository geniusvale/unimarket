import 'package:flutter/material.dart';

import '../models/seller_request/seller_request_model.dart';
import '../utilities/constants.dart';

class SellerRequestProvider extends ChangeNotifier {
  List<SellerRequestModel>? allRequest;

  submitRequest({String? nim, phone, address}) async {
    //CEK TELAH JADI SELLER & DUPLIKAT DATA REQUEST BELUM BENER
    await supabase.from('seller_request').insert(
      {
        'users_id': supabase.auth.currentUser!.id,
        'nim': nim,
        'phone': phone,
        'address': address,
      },
    );
    notifyListeners();
    // }
  }

  Future<bool> checkIfHasRequested(
      String submittedNIM, submittedPhone, submittedAddress) async {
    final result = await supabase
        .from('seller_request')
        .select<List<Map<String, dynamic>>>('*')
        .match({
      'users_id': supabase.auth.currentUser!.id,
      // 'nim': submittedNIM,
      // 'phone': submittedPhone,
      // 'address': submittedAddress,
    });
    // print(result);
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<SellerRequestModel>> getSellerRequestList() async {
    final allSellerRequestList =
        await supabase.from('seller_request').select('*, profiles!inner(*)');
    final allRequestData = allSellerRequestList
        .map<SellerRequestModel>((e) => SellerRequestModel.fromJson(e))
        .toList();
    allRequest = allRequestData;
    // print(allSellerRequestList);
    notifyListeners();
    return allRequestData;
    //WORKING GOOD
  }

  acceptSellerRequest({required String nim, userId, phone, address}) async {
    try {
      await supabase.from('profiles').update({
        'nim': nim,
        'isSeller': true,
        'phone': phone,
        'address': address,
      }).match({
        'id': userId,
      });
      await supabase.from('seller_request').delete().eq('users_id', userId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  declineSellerRequest(String userId) async {
    try {
      await supabase.from('seller_request').delete().eq('users_id', userId);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
