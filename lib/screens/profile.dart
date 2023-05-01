import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/screens/auth/register.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // final ImageProvider blankPP = SvgPicture.asset('assets/images/blankpp.svg');
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: formPadding,
            child: Row(
              children: [
                //Kalau Tidak Ada Login, Gambar Harus Ada Replacement
                CircleAvatar(
                  radius: 48,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://picsum.photos/id/$randomNumber/200/200',
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.photo_camera_rounded,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                formSpacer,
                //Kalau Tidak Ada Login, Diganti Tombol Atau Blank Text
                authProvider.unAuthorized
                    ? Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                },
                                child: const Text('Login')),
                          ),
                          formSpacer,
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  );
                                },
                                child: const Text('Register')),
                          ),
                        ],
                      ))
                    : Expanded(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileProvider.loggedUserData.username
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(profileProvider.loggedUserData.email
                                  .toString()),
                              const Text('STATUS'),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
          formSpacer,
          const Divider(),
          //Kalau Tidak Ada Login, Redirect Ke Login Page
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/edit.svg',
              width: 20,
              height: 20,
            ),
            title: const Text('Request Sebagai Penjual'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              if (authProvider.unAuthorized == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              } else {
                return;
              }
            },
          ),
          //Kalau Tidak Ada Login, Redirect Ke Login Page
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/shop.svg',
              width: 20,
              height: 20,
            ),
            title: const Text('Kelola Toko (\'Tokomu\')'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              if (authProvider.unAuthorized == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Store(),
                  ),
                );
              }
            },
          ),
          //Kalau Tidak Ada Login, Hide Widgetnya
          Visibility(
            //Benerin Lagi Nanti Disini
            visible:
                authProvider.unAuthorized ? false : !authProvider.unAuthorized,
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/exit.svg',
                width: 20,
                height: 20,
                color: Colors.red[900],
              ),
              title: const Text('Logout'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () async {
                await authProvider.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
