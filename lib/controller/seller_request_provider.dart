import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/seller_request/seller_request_model.dart';
import '../utilities/constants.dart';

class SellerRequestProvider extends ChangeNotifier {
  final nimC = TextEditingController();
  List<SellerRequestModel>? allRequest;

  void sumbitRequest({String? user_id, nim}) async {
    await supabase.from('seller_request').insert(
      {
        'users_id': user_id,
        'nim': nim,
      },
    );
    notifyListeners();
    //WORKING GOOD
  }

  Future<List<SellerRequestModel>> getSellerRequestList() async {
    final supabase = Supabase.instance.client;
    final allSellerRequestList = await supabase.from('seller_request').select();
    final allRequestData = allSellerRequestList
        .map<SellerRequestModel>((e) => SellerRequestModel.fromJson(e))
        .toList();
    allRequest = allRequestData;
    print(allSellerRequestList);
    notifyListeners();
    return allRequestData;
    //WORKING GOOD
  }
}
