import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/screens/homepage.dart';

import '../utilities/constants.dart';

class AuthProvider extends ChangeNotifier {
  bool kIsWeb = true;
  final formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  //Register dengan Email
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
      //Memanggil Function Masukkan Data Ke Tabel Profiles(Public)
      insertToProfilesTable(username);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  //Login dengan Email
  login({String? email, password}) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;

      //Menginisiasi SharedPref
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //Menyimpan Status Login
      await prefs.setBool('isLoggedIn', true);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //LOGOUT
  logout() async {
    try {
      await supabase.auth.signOut();
      //Menginisiasi SharedPref
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //Menghapus Status Login
      await prefs.remove('isLoggedIn');
    } catch (e) {
      rethrow;
    }
  }

  //Mengambil Info Session
  getSession() async {
    final Session? session = supabase.auth.currentSession;
  }

  //Mengambil Info User
  getUser() async {
    final User? user = supabase.auth.currentUser;
  }

  //Memasukkan User Ke Tabel Profil(Public) Setelah Login Berhasil
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
    } catch (error) {
      print('Ini error insert user ke profiles ${error.toString()}');
    }
  }

  //Mengambil Info Dari Autentikasi (JANGAN DIPAKE!!)
  // listenAuthEvents() {
  //   final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
  //     final AuthChangeEvent event = data.event;
  //     final Session? session = data.session;
  //   });
  //   authSubscription.cancel();
  //   notifyListeners();
  //   print(authSubscription);
  // }

  //Cek Kondisi Login/Tidak
  void checkIsLoggedIn(BuildContext context) async {
    final loginState = await SharedPreferences.getInstance();
    final isLoggedIn = loginState.getBool('isLoggedIn') ?? false;
    final profileProvider =
        provider.Provider.of<ProfileProvider>(context, listen: false);
    print(isLoggedIn.toString());
    //Kalau Ada Sesi Login, Auto Ke Halaman HomePage
    if (isLoggedIn == true) {
      //INIT dan Ambil Data Profil
      await profileProvider.getProfileDataFromAuth(context);
      //Redirect Ke HomePage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    } else {
      null;
    }
    notifyListeners();
  }
}
