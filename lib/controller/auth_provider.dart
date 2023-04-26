import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utilities/constants.dart';

class AuthProvider extends ChangeNotifier {
  register(String username, email, password) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
        },
      );
      final Session? session = res.session;
      final User? user = res.user;

      insertToProfilesTable(username);
    } catch (error) {
      rethrow;
    }
  }

  login({String? email, password}) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  getSession() async {
    final Session? session = supabase.auth.currentSession;
  }

  getUser() async {
    final User? user = supabase.auth.currentUser;
  }

  insertToProfilesTable(String username) async {
    try {
      final user = supabase.auth.currentUser;
      final insertToProfilesTable = {
        'id': user?.id,
        'username': username,
        'email': user?.email,
      };

      final response =
          await supabase.from('profiles').upsert(insertToProfilesTable);
      if (response) {}
    } catch (error) {
      print('Ini error insert user ke profiles ${error.toString()}');
    }
  }
}
