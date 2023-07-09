import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/controller/seller_request_provider.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/screens/auth/register.dart';
import 'package:unimarket/screens/confirm_request.dart';
import 'package:unimarket/screens/profile/edit_profile.dart';
import 'package:unimarket/screens/store/store.dart';
import 'package:unimarket/utilities/constants.dart';

import '../../controller/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? foto;
  bool isNoPic = true;
  bool hideWidget = true;
  final nimC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //CEK NANTI, BELUM DIIMPLEMENT!
  checkIfHasRequestedForSeller(BuildContext context) async {
    final sellerRequestProvider =
        Provider.of<SellerRequestProvider>(context, listen: false);
    await sellerRequestProvider.getSellerRequestList();
    if (sellerRequestProvider.allRequest!
        .contains(supabase.auth.currentUser!.id)) {
      return hideWidget;
    } else {
      return !hideWidget;
    }
  }

  @override
  void initState() {
    checkIfHasRequestedForSeller(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final sellerRequestProvider =
        Provider.of<SellerRequestProvider>(context, listen: false);
    // print(sellerRequestProvider.getSellerRequestList());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: formPadding,
              child: Row(
                children: [
                  //Kalau Tidak Ada Login, Gambar Harus Ada Replacement
                  GestureDetector(
                    onTap: () async {
                      if (profileProvider.loggedUserData.avatar_url == null) {
                        await profileProvider.uploadFotoProfil();
                        setState(() {});
                      } else {
                        await profileProvider.updateFotoProfil();
                        setState(() {});
                      }
                    },
                    child: ClipOval(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: profileProvider.loggedUserData.avatar_url == null
                            ? SvgPicture.asset('assets/images/blankpp.svg')
                            : Image.network(
                                profileProvider.loggedUserData.avatar_url!),
                        // CachedNetworkImage(
                        //     imageUrl:
                        //         profileProvider.loggedUserData.avatar_url!),
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
                                  child: const Text('Login'),
                                ),
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
                                  child: const Text('Register'),
                                ),
                              ),
                            ],
                          ),
                        )
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
                                Text(
                                  'Saldo : ${numberCurrency.format(profileProvider.loggedUserData.saldo ?? 0)}',
                                ),
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
              leading: Image.asset(
                'assets/icons/edit-profile.png',
                width: 25,
                height: 25,
              ),
              title: const Text('Edit Profil'),
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
                      builder: (context) => const EditProfile(),
                    ),
                  );
                }
              },
            ),
            Visibility(
              visible: profileProvider.loggedUserData.isSeller == false &&
                  profileProvider.loggedUserData.isAdmin == false,
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  width: 20,
                  height: 20,
                ),
                title: const Text('Request Sebagai Penjual'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  //Kalau Tidak Ada Login, Redirect Ke Login Page
                  if (authProvider.unAuthorized == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: ((ctx) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nimC,
                                  decoration: formDecor(hint: 'Masukkan NIM'),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              await sellerRequestProvider
                                                  .submitRequest(
                                                context: ctx,
                                                // nim: sellerRequestProvider
                                                //     .nimC.text,
                                                nim: nimC.text,
                                              );
                                              print(nimC.text);
                                            } catch (e) {
                                              Navigator.pop(context);
                                              snackbar(context, e.toString(),
                                                  Colors.black);
                                            }
                                          },
                                          child: const Text('Kirim Request'),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }
                },
              ),
            ),
            //Untuk Admin, Perbaiki dan Implementasi Nanti!
            Visibility(
              visible: profileProvider.loggedUserData.isAdmin == true,
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/list-check.svg',
                  width: 20,
                  height: 20,
                ),
                title: const Text('Konfirmasi Request Sebagai Penjual'),
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
                        builder: (context) => const ConfirmSellerRequest(),
                      ),
                    );
                  }
                },
              ),
            ),
            //Kalau Tidak Ada Login, Redirect Ke Login Page
            Visibility(
              visible: profileProvider.loggedUserData.isSeller == true,
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/shop.svg',
                  width: 20,
                  height: 20,
                ),
                title: const Text('Kelola Toko'),
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
            ),
            Visibility(
              visible: profileProvider.loggedUserData.isSeller == true,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/money.png',
                  width: 25,
                  height: 25,
                ),
                title: const Text('Pencairan Dana'),
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
            ),
            //Kalau Tidak Ada Login, Hide Widgetnya
            Visibility(
              visible: authProvider.unAuthorized
                  ? false
                  : !authProvider.unAuthorized,
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
      ),
    );
  }
}
