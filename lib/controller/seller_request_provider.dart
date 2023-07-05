import 'package:flutter/material.dart';

import '../models/seller_request/seller_request_model.dart';
import '../utilities/constants.dart';

class SellerRequestProvider extends ChangeNotifier {
  final nimC = TextEditingController();
  List<SellerRequestModel>? allRequest;

  submitRequest({String? userId, nim, required BuildContext context}) async {
    final hasSubmit = await checkIfHasRequested();
    if (hasSubmit == true) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda Sudah Mengirim Request!'),
        ),
      );
    } else {
      await supabase.from('seller_request').insert(
        {
          'users_id': userId,
          'nim': nim,
        },
      );
      nimC.clear;
      notifyListeners();
    }
  }

  Future<bool> checkIfHasRequested() async {
    final result = await supabase
        .from('seller_request')
        .select()
        .match({'users_id': supabase.auth.currentUser!.id});
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<SellerRequestModel>> getSellerRequestList() async {
    final allSellerRequestList =
        await supabase.from('seller_request').select('*, profiles!inner(*)');
    final allRequestData = allSellerRequestList
        .map<SellerRequestModel>((e) => SellerRequestModel.fromJson(e))
        .toList();
    allRequest = allRequestData;
    print(allSellerRequestList);
    notifyListeners();
    return allRequestData;
    //WORKING GOOD
  }

  acceptSellerRequest(String nim, userId) async {
    try {
      await supabase.from('profiles').update({
        'nim': nim,
        'isSeller': true,
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
