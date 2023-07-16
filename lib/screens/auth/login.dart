import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimarket/controller/auth_provider.dart';
import 'package:unimarket/screens/auth/register.dart';
import 'package:unimarket/screens/homepage.dart';
import 'package:unimarket/utilities/constants.dart';

import '../../controller/profile_provider.dart';
import '../../utilities/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool kIsWeb = true;
  bool? isLoading;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {},
    // );
    checkIsLoggedIn(context);
    super.initState();
  }

  checkIsLoggedIn(BuildContext context) async {
    final loginState = await SharedPreferences.getInstance();
    final isLoggedIn = loginState.getBool('isLoggedIn') ?? false;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print('Status isLoggedIn ${isLoggedIn.toString()}');
    //Kalau Ada Sesi Login, Auto Ke Halaman HomePage
    if (isLoggedIn == true) {
      //INIT dan Ambil Data Profil
      await profileProvider.getProfileDataFromAuth(context);
      authProvider.unAuthorized = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: formPadding,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                giantHeader,
                formSpacer,
                TextFormField(
                  controller: authProvider.emailC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: borderRadiusStd),
                    hintText: 'Email',
                  ),
                ),
                formSpacer,
                TextFormField(
                  controller: authProvider.passwordC,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderRadius: borderRadiusStd),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: _passwordVisible
                          ? SvgPicture.asset('assets/icons/eye.svg',
                              color: Colors.grey)
                          : SvgPicture.asset('assets/icons/eye-crossed.svg',
                              color: Colors.grey),
                    ),
                  ),
                ),
                formSpacer,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(color: Colors.white),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            isLoading = true;
                            showGeneralDialog(
                              context: context,
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      loadingIndicator,
                            );
                            await authProvider.login(
                              email: authProvider.emailC.text,
                              password: authProvider.passwordC.text,
                            );
                            authProvider.emailC.clear();
                            authProvider.passwordC.clear();
                            await profileProvider
                                .getProfileDataFromAuth(context);
                            isLoading = false;
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          } catch (e) {
                            snackbar(context, e.toString(), Colors.black);
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
                formSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                    formSpacer,
                    const Text('Or'),
                    formSpacer,
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                formSpacer,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          textStyle: const TextStyle(color: Colors.white),
                          shape: const RoundedRectangleBorder(
                              borderRadius: borderRadiusStd),
                        ),
                        onPressed: () async {},
                        icon: SvgPicture.asset(
                          'assets/icons/google.svg',
                          height: 16,
                        ),
                        label: const Text(
                          'Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                formSpacer,
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Belum punya akun?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text('Daftar'),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const Text('Masuk Sebagai Tamu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
