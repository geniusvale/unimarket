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
import 'package:unimarket/screens/store/withdraw.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:unimarket/utilities/widgets.dart';

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
  final phoneC = TextEditingController();
  final addressC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? isLoading;

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
                        try {
                          isLoading = true;
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    loadingIndicator,
                          );
                          await profileProvider.uploadFotoProfil();
                          isLoading = false;
                          Navigator.of(context, rootNavigator: true).pop();
                          setState(() {});
                        } catch (e) {
                          isLoading = false;
                          Navigator.of(context, rootNavigator: true).pop();
                          snackbar(context, e.toString(), Colors.black);
                        }
                      } else {
                        try {
                          isLoading = true;
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    loadingIndicator,
                          );
                          await profileProvider.updateFotoProfil(
                            currentAvatarUrl:
                                profileProvider.loggedUserData.avatar_url!,
                          );
                          isLoading = false;
                          Navigator.of(context, rootNavigator: true).pop();
                          setState(() {});
                        } catch (e) {
                          isLoading = false;
                          Navigator.of(context, rootNavigator: true).pop();
                          snackbar(context, e.toString(), Colors.black);
                        }
                      }
                    },
                    child: ClipOval(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: profileProvider.loggedUserData.avatar_url == null
                            ? SvgPicture.asset('assets/images/blankpp.svg')
                            : Image.network(
                                profileProvider.loggedUserData.avatar_url!,
                                fit: BoxFit.fill,
                              ),
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
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(ctx).viewInsets.bottom,
                            ),
                            child: Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.grey[300],
                                    margin: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 16),
                                    child: Column(
                                      children: [
                                        handleBar,
                                        formSpacer,
                                        TextFormField(
                                          controller: nimC,
                                          decoration: formDecor(
                                            hint: 'Masukkan NIM',
                                            label: 'NIM',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 10) {
                                              return 'NIM tidak sesuai!';
                                            }
                                            return null;
                                          },
                                        ),
                                        formSpacer,
                                        TextFormField(
                                          controller: phoneC,
                                          decoration: formDecor(
                                              hint: 'Masukkan Nomor HP',
                                              label: 'Nomor HP'),
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Nomor HP tidak boleh kosong!';
                                            }
                                            return null;
                                          },
                                        ),
                                        formSpacer,
                                        TextFormField(
                                          controller: addressC,
                                          decoration: formDecor(
                                              hint: 'Masukkan Alamat',
                                              label: 'Alamat'),
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Alamat tidak boleh kosong!';
                                            }
                                            return null;
                                          },
                                        ),
                                        formSpacer,
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: BlueButton(
                                      padding: 8,
                                      teks: 'Kirim Request',
                                      onPressed: () async {
                                        try {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final check =
                                                await sellerRequestProvider
                                                    .checkIfHasRequested(
                                              nimC.text,
                                              phoneC.text,
                                              addressC.text,
                                            );
                                            if (check == true) {
                                              Navigator.pop(context);
                                              snackbar(
                                                context,
                                                'Data Sudah Ada!',
                                                Colors.red,
                                              );
                                            } else {
                                              await sellerRequestProvider
                                                  .submitRequest(
                                                nim: nimC.text,
                                                phone: phoneC.text,
                                                address: addressC.text,
                                              );
                                              Navigator.pop(context);
                                              snackbar(
                                                context,
                                                'Berhasil Mengirim Request',
                                                Colors.green,
                                              );
                                            }
                                          }
                                        } catch (e) {
                                          Navigator.pop(context);
                                          snackbar(
                                            context,
                                            e.toString(),
                                            Colors.black,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
              visible: true,
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
                        builder: (context) => const Withdraw(),
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
