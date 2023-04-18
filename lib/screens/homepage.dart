import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/screens/home.dart';

import 'cart.dart';
import 'profile.dart';
import 'wishlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    print(_currentIndex);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   titleTextStyle: const TextStyle(color: Colors.blueGrey),
      //   title: const Text('UniMarket', style: TextStyle(fontSize: 24)),
      // ),
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        children: const [
          Home(),
          Wishlist(),
          Cart(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          controller.animateToPage(
            value,
            duration: const Duration(milliseconds: 3),
            curve: Curves.ease,
          );
        },
        fixedColor: Colors.black,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 20,
                height: 20,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 20,
                height: 20,
              ),
              label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shopping-bag.svg',
                width: 20,
                height: 20,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              width: 20,
              height: 20,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
