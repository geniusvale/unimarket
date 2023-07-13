import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/profile/profile_model.dart';
import '../utilities/constants.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _loggedUserData;
  ProfileModel get loggedUserData =>
      _loggedUserData ?? const ProfileModel(id: '');

  List<ProfileModel>? allProfiles;
  ProfileModel? profileData;

  //Mengambil dan Simpan Info User Yang Telah Login
  getProfileDataFromAuth(BuildContext context) async {
    try {
      final res = await supabase
          .from('profiles')
          .select('*')
          .eq(
            'id',
            supabase.auth.currentUser!.id,
          )
          .single();
      _loggedUserData = ProfileModel.fromJson(res);
      print(res);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future getProfileById(String id) async {
    final profileById =
        await supabase.from('profiles').select('*').eq('id', id).single();
    profileData = ProfileModel.fromJson(profileById);
    print(profileData!.isSeller);
    notifyListeners();
    return profileById;
  }

  Future<List<ProfileModel>> getAllProfile() async {
    try {
      final allProfileList = await supabase.from('profiles').select();
      final allProfileData = allProfileList
          .map<ProfileModel>(
            (e) => ProfileModel.fromJson(e),
          )
          .toList();
      allProfiles = allProfileData;
      print(allProfiles);
      notifyListeners();
      return allProfileData;
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
        _loggedUserData = loggedUserData.copyWith(avatar_url: photoUrl);
        //Harus Ada SetState Setelah Ini
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
        _loggedUserData = loggedUserData.copyWith(avatar_url: photoUrl);
        //Harus Ada SetState Setelah Ini
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    } else {
      // CANCEL
    }
    //Harus Ada SetState Setelah Ini
    notifyListeners();
  }

  updateProfileData({required String username, email, phone, address}) async {
    await supabase.from('profiles').update({
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
    }).eq('id', supabase.auth.currentUser!.id);
  }
}
