import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController();

  //Function Pindah Halaman di PageView
  changePage(int value) {
    currentIndex = value;
    print('Index sekarang $currentIndex}');
    notifyListeners();
  }
}
