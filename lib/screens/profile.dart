import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/screens/store/store.dart';
import 'package:unimarket/utilities/constants.dart';

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
            Padding(
              padding: formPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://picsum.photos/id/$randomNumber/200/200',
                    ),
                    // NetworkImage(
                    //   'https://picsum.photos/id/$randomNumber/200/200',
                    // ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.photo_camera_rounded,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  formSpacer,
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      // color: Colors.blueGrey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'NAMAMU DISINI',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('contoh@gmail.com'),
                          Text('STATUS'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            formSpacer,
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/edit.svg',
                width: 20,
                height: 20,
              ),
              title: const Text('Request Sebagai Penjual'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/shop.svg',
                width: 20,
                height: 20,
              ),
              title: const Text('Kelola Toko (\'Tokomu\')'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Store(),
                  ),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/exit.svg',
                width: 20,
                height: 20,
                color: Colors.red[900],
              ),
              title: const Text('Logout'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () async {
                await AuthProvider().logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
