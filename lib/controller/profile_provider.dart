import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/profile/profile_model.dart';
import '../utilities/constants.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? loggedUserData;
  // ProfileModel get loggedUserData =>
  //     _loggedUserData ?? const ProfileModel(id: '');

  List<ProfileModel>? allProfiles;
  ProfileModel? profileData;

  getProfileDataFromAuth() async {
    //Mengambil dan Simpan Info User Yang Telah Login
    try {
      final res = await supabase
          .from('profiles')
          .select('*, address:address_id(*)')
          .eq('id', supabase.auth.currentUser!.id)
          .single();
      loggedUserData = ProfileModel.fromJson(res);
      print(res);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  uploadFotoProfil() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      File pickedPhoto = File(result.files.single.path!);
      String pickedPhotoName = result.files.first.name;

      try {
        //Upload FOTO ke supabase storage
        await supabase.storage.from('profile-pic').upload(
            '${supabase.auth.currentUser!.id}/$pickedPhotoName', pickedPhoto);

        //Mengambil LINK foto yang diupload
        final photoUrl = supabase.storage
            .from('profile-pic/${supabase.auth.currentUser!.id}')
            .getPublicUrl(pickedPhotoName);

        //Menyimpan LINK dari storage ke Tabel Profiles
        await supabase.from('profiles').update({
          'avatar_url': photoUrl,
        }).eq('id', supabase.auth.currentUser!.id);
        loggedUserData = loggedUserData!.copyWith(avatar_url: photoUrl);
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    } else {
      // CANCEL
    }
  }

  updateFotoProfil({required String currentAvatarUrl}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      File pickedPhoto = File(result.files.single.path!);
      String pickedPhotoName = result.files.first.name;

      try {
        await supabase.storage.from('profile-pic').remove([
          '${supabase.auth.currentUser!.id}/${currentAvatarUrl.split('/').last}'
        ]);
        await supabase.storage.from('profile-pic').upload(
            '${supabase.auth.currentUser!.id}/$pickedPhotoName', pickedPhoto);
        final photoUrl = supabase.storage
            .from('profile-pic/${supabase.auth.currentUser!.id}')
            .getPublicUrl(pickedPhotoName);
        //UPDATE KE TABLE PRODUCT
        await supabase.from('profiles').update({
          'avatar_url': photoUrl,
        }).eq('id', supabase.auth.currentUser!.id);
        loggedUserData = loggedUserData!.copyWith(avatar_url: photoUrl);
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    } else {
      // CANCEL
    }
    notifyListeners();
  }

  updateProfileData(
      {required String username,
      required String email,
      required String phone,
      required String alamat,
      required String cityId,
      required String cityName,
      required String cityType}) async {
    //Update data umumnya
    await supabase.from('profiles').update({
      'username': username,
      'email': email,
      'phone': phone,
    }).eq('id', supabase.auth.currentUser!.id);

    //Mengambil Data di Table Alamat
    final addressData = await supabase
        .from('address')
        .select<List<Map>>('*')
        .eq('users_id', supabase.auth.currentUser!.id);
    print(addressData);

    //Kalau Belum Punya Data Alamat, buat Baru dan Masukkan ID yang baru dibuat
    //Ke Table Profiles User Tersebut
    if (addressData.isEmpty) {
      //Buat Data Alamat Baru
      await supabase.from('address').insert({
        'users_id': supabase.auth.currentUser!.id,
        'alamat': alamat,
        'city_id': cityId,
        'city_name': cityName,
        'type': cityType
      });
      //Ambil ID Alamat yang baru dibuat dan masukkan ke Profiles
      final addressId = await supabase
          .from('address')
          .select('id, created_at')
          .eq('users_id', supabase.auth.currentUser!.id)
          .order('created_at', ascending: false)
          .limit(1)
          .single();
      print(addressId);
      await supabase.from('profiles').update({
        'address_id': '${addressId['id']}',
      }).eq('id', supabase.auth.currentUser!.id);
    } else {
      await supabase.from('address').update({
        'alamat': alamat,
        'city_id': cityId,
        'city_name': cityName,
        'type': cityType
      }).eq('users_id', supabase.auth.currentUser!.id);
    }
    //Refresh Data
    await getProfileDataFromAuth();
    notifyListeners();
  }

  // Future getProfileById(String id) async {
  //   final profileById = await supabase
  //       .from('profiles')
  //       .select('*, address:address_id(*)')
  //       .eq('id', id)
  //       .single();
  //   profileData = ProfileModel.fromJson(profileById);
  //   loggedUserData = ProfileModel.fromJson(profileById);
  //   print(profileData!.isSeller);
  //   notifyListeners();
  //   return profileById;
  // }

  // Future<List<ProfileModel>> getAllProfile() async {
  //   try {
  //     final allProfileList =
  //         await supabase.from('profiles').select('*, address:address_id(*)');
  //     final allProfileData = allProfileList
  //         .map<ProfileModel>(
  //           (e) => ProfileModel.fromJson(e),
  //         )
  //         .toList();
  //     allProfiles = allProfileData;
  //     print(allProfiles);
  //     notifyListeners();
  //     return allProfileData;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
