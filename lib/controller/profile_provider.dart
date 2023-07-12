import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    //Ambil File
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      // allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'tif', 'tiff', 'bmp'],
    );

    if (pickedFile != null) {
      //Direktori File
      File filePath = File(pickedFile.files.single.path!);
      //Nama file dan Ekstensinya
      String fileName = pickedFile.files.first.name;
      //Link foto yang terupload
      String? fileUrl;

      try {
        //Upload FOTO ke supabase storage
        final String uploadPath = await supabase.storage
            .from('profile-pic')
            .upload('${supabase.auth.currentUser!.id}/$fileName', filePath);

        //Mengambil LINK foto yang diupload
        final publicUrl = supabase.storage
            .from('profile-pic/${supabase.auth.currentUser!.id}')
            .getPublicUrl(fileName);
        fileUrl = publicUrl;
        print(fileUrl);

        //Menyimpan LINK dari storage ke Tabel Profiles
        final simpanKeTabel = await supabase
            .from('profiles')
            .update({'avatar_url': fileUrl}).match(
          {'id': supabase.auth.currentUser!.id},
        );
        //Harus Ada SetState Setelah Ini
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    } else {
      // User canceled the picker
    }
  }

  updateFotoProfil() async {
    //Ambil File
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      // allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'tif', 'tiff', 'bmp'],
      allowMultiple: false,
    );

    if (pickedFile != null) {
      //Direktori File
      File filePath = File(pickedFile.files.single.path!);
      //Nama file dan Ekstensinya
      String fileName = pickedFile.files.first.name;
      //Link foto yang terupload
      String? fileUrl;

      try {
        List<String> splitCurrentFileName =
            loggedUserData.avatar_url!.split('/');
        String currentFileName = splitCurrentFileName.last;

        //UPDATE FOTO ke supabase storage
        final String uploadPath =
            await supabase.storage.from('profile-pic').update(
                  '${supabase.auth.currentUser!.id}/$currentFileName',
                  filePath,
                  fileOptions: const FileOptions(upsert: false),
                );

        // await refreshAndUpdate(fileName);

        // //Mengambil LINK foto yang diupload
        // final publicUrl = supabase.storage
        //     .from('profile-pic/${supabase.auth.currentUser!.id}')
        //     .getPublicUrl(fileName);
        // fileUrl = publicUrl;
        // print(fileUrl);

        // //Menyimpan LINK dari storage ke Tabel Profiles
        // final simpanKeTabel = await supabase
        //     .from('profiles')
        //     .update({'avatar_url': fileUrl}).match(
        //   {'id': supabase.auth.currentUser!.id},
        // );

        //Harus Ada SetState Setelah Ini
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    } else {
      // User canceled the picker
    }
  }

  refreshAndUpdate(String fileName) async {
    //Mengambil LINK foto yang diupload
    final publicUrl = supabase.storage
        .from('profile-pic/${supabase.auth.currentUser!.id}')
        .getPublicUrl(fileName);

    print(publicUrl);

    //Menyimpan LINK dari storage ke Tabel Profiles
    final simpanKeTabel =
        await supabase.from('profiles').update({'avatar_url': publicUrl}).match(
      {'id': supabase.auth.currentUser!.id},
    );
  }
}
