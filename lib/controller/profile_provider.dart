import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile/profile_model.dart';
import '../utilities/constants.dart';

class ProfileProvider extends ChangeNotifier {
  late ProfileModel _loggedUserData;
  ProfileModel get loggedUserData => _loggedUserData;

  getProfileDataFromAuth() async {
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
  }
}
