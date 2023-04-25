import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utilities/constants.dart';

class AuthProvider extends ChangeNotifier {
  register(String username, email, password) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
      },
    );
    final Session? session = res.session;
    final User? user = res.user;
  }

  login() async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: 'example@email.com',
      password: 'example-password',
    );
    final Session? session = res.session;
    final User? user = res.user;
  }

  logout() async {
    await supabase.auth.signOut();
  }

  getSession() async {
    final Session? session = supabase.auth.currentSession;
  }

  getUser() async {
    final User? user = supabase.auth.currentUser;
  }
}
