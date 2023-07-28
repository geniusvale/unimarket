import 'package:flutter/material.dart';

import '../models/seller_request/seller_request_model.dart';
import '../utilities/constants.dart';

class SellerRequestProvider extends ChangeNotifier {
  List<SellerRequestModel>? allRequest;

  submitRequest({String? nim, phone, alamat, cityId, cityName, type}) async {
    await supabase.from('seller_request').insert(
      {
        'users_id': supabase.auth.currentUser!.id,
        'nim': nim,
        'phone': phone,
        'alamat': alamat,
        'city_id': cityId,
        'city_name': cityName,
        'type': type
      },
    );
    notifyListeners();
  }

  Future<bool> checkIfHasRequested() async {
    final result = await supabase
        .from('seller_request')
        .select<List<Map<String, dynamic>>>('*')
        .eq('users_id', supabase.auth.currentUser!.id);
    print('APakah ada request seller = $result');
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<SellerRequestModel>> getSellerRequestList() async {
    final allSellerRequestList = await supabase
        .from('seller_request')
        .select('*, profiles!inner(*, address:address_id(*))');
    final allRequestData = allSellerRequestList
        .map<SellerRequestModel>((e) => SellerRequestModel.fromJson(e))
        .toList();
    allRequest = allRequestData;
    // print(allSellerRequestList);
    notifyListeners();
    return allRequestData;
    //WORKING GOOD
  }

  acceptSellerRequest(
      {required String nim,
      userId,
      phone,
      alamat,
      cityId,
      cityName,
      cityType}) async {
    try {
      //CEK SUDAH PUNYA DATA ALAMAT BELUM
      final addressData = await supabase
          .from('address')
          .select<List<Map>>('*')
          .eq('users_id', userId);
      print(addressData);
      //Kalau Belum Punya Data Alamat, buat Baru dan Masukkan ID yang baru dibuat
      //Ke Table Profiles User Tersebut
      if (addressData.isEmpty) {
        //Buat Data Alamat Baru
        await supabase.from('address').insert({
          'users_id': userId,
          'alamat': alamat,
          'city_id': cityId,
          'city_name': cityName,
          'type': cityType
        });
        //Ambil ID Alamat yang baru dibuat dan masukkan ke Profiles
        final addressId = await supabase
            .from('address')
            .select('id, created_at')
            .eq('users_id', userId)
            .order('created_at', ascending: false)
            .limit(1)
            .single();
        print(addressId);
        await supabase.from('profiles').update({
          'address_id': '${addressId['id']}',
        }).eq('id', userId);
        // UPDATE ID ADDRESS KE PROFIL
        await supabase.from('profiles').update({
          'nim': nim,
          'isSeller': true,
          'phone': phone,
          'address_id': addressId['id'],
        }).eq('id', userId);
      } else {
        await supabase.from('profiles').update({
          'nim': nim,
          'isSeller': true,
          'phone': phone,
        }).eq('id', userId);
        await supabase.from('address').update({
          'alamat': alamat,
          'city_id': cityId,
          'city_name': cityName,
          'type': cityType
        }).eq('users_id', userId);
      }
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
