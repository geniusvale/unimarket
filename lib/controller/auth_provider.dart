import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/controller/home_provider.dart';

import '../utilities/constants.dart';

class AuthProvider extends ChangeNotifier {
  bool kIsWeb = true;

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  bool unAuthorized = true;

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
      unAuthorized = false;
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
      unAuthorized = false;
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
      unAuthorized = true;
      HomeProvider().pageController.dispose();
      HomeProvider().currentIndex = 0;
      notifyListeners();
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

  //Cek Kondisi Login/Tidak
  // checkIsLoggedIn(BuildContext context) async {
  //   final loginState = await SharedPreferences.getInstance();
  //   final isLoggedIn = loginState.getBool('isLoggedIn') ?? false;
  //   final profileProvider =
  //       provider.Provider.of<ProfileProvider>(context, listen: false);
  //   print('Status isLoggedIn ${isLoggedIn.toString()}');
  //   //Kalau Ada Sesi Login, Auto Ke Halaman HomePage
  //   if (isLoggedIn == true) {
  //     //INIT dan Ambil Data Profil
  //     await profileProvider.getProfileDataFromAuth(context);
  //     unAuthorized = false;
  //     //Redirect Ke HomePage
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const HomePage(),
  //       ),
  //       (route) => false,
  //     );
  //     notifyListeners();
  //   } else {
  //     null;
  //   }
  // }
}
