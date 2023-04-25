import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:badges/badges.dart' as badges;

import '../controller/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int randomNumber = Random().nextInt(999);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            badges.Badge(
              child: CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/id/$randomNumber/200/200',
                ),
              ),
              position: badges.BadgePosition.topEnd(top: 12, end: 1),
            ),
            formSpacer,
            ListTile(
              leading: const FlutterLogo(),
              title: const Text('Request Sebagai Penjual'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            ListTile(
              leading: const FlutterLogo(),
              title: const Text('Kelola Toko'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthProvider().logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
