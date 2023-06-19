import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart'as provider;
import 'package:unimarket/controller/seller_request_provider.dart';
import 'package:unimarket/models/seller_request/seller_request_model.dart';

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
      final User? user = supabase.auth.currentUser;
      final uData = await supabase
          .from('profiles')
          .select('*')
          .eq(
            'id',
            user!.id,
          )
          .single();
      _loggedUserData = ProfileModel.fromJson(uData);
      print(uData);
      print(loggedUserData.username);
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

  
}
