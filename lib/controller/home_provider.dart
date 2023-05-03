import 'package:flutter/material.dart';

import '../screens/homepage.dart';
import '../screens/orders.dart';
import '../screens/profile.dart';
import '../screens/wishlist.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController();

  List pages = [
    const Home(),
    const Wishlist(),
    const Orders(),
    const Profile(),
  ];

  //Function Pindah Halaman di PageView
  changePage(int value) {
    currentIndex = value;
    print('Index sekarang $currentIndex}');
    notifyListeners();
  }
}
