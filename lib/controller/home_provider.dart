import 'dart:math';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'product_provider.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController();
  
  changePage(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
