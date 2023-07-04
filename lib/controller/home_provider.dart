import 'package:flutter/material.dart';

import '../screens/homepage.dart';
import '../screens/transactions/transactions.dart';
import '../screens/profile.dart';
import '../screens/wishlist.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController();

  List pages = [
    const Home(),
    const Wishlist(),
    const Transactions(),
    const Profile(),
  ];

  //Function Pindah Halaman di PageView
  changePage(int value) {
    currentIndex = value;
    print('Index sekarang $currentIndex}');
    notifyListeners();
  }
}
