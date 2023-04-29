import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile/profile_model.dart';
import '../utilities/constants.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _loggedUserData;
  ProfileModel get loggedUserData =>
      _loggedUserData ?? const ProfileModel(id: '');

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

  blockUnauthorized(BuildContext context) {
    final User? user = supabase.auth.currentUser;
    if (user == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Harus Login'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Kembali')),
            ],
          );
        },
      );
    }
    notifyListeners();
  }

  //Next Coba Block Unauthorized Dengan VISIBILITY WIDGET
}
