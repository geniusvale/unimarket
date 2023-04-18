import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:typed_data';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.blueGrey),
        title: const Text('UniMarket', style: TextStyle(fontSize: 24)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: Text('HomePage')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
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
