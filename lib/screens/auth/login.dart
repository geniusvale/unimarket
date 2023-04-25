import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/screens/auth/register.dart';
import 'package:unimarket/screens/homepage.dart';
import 'package:unimarket/utilities/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = true;
  bool kIsWeb = true;
  final formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                const Placeholder(
                  fallbackHeight: 250,
                ),
                formSpacer,
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: borderRadiusStd),
                    hintText: 'Email',
                  ),
                ),
                formSpacer,
                TextFormField(
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
                          ? SvgPicture.asset('assets/icons/eye.svg')
                          : SvgPicture.asset('assets/icons/eye-crossed.svg'),
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
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
                    const Text('Or'),
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
                        onPressed: () {},
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
                )
                // SupaEmailAuth(
                //   authAction: SupaAuthAction.signIn,
                //   redirectUrl:
                //       kIsWeb ? null : 'io.supabase.flutter://reset-callback/',
                //   onSuccess: (AuthResponse response) {
                //     // do something, for example: navigate('home');
                //   },
                //   onError: (error) {
                //     // do something, for example: navigate("wait_for_email");
                //   },
                // ),
                // SupaSocialsAuth(
                //   socialProviders: const [
                //     SocialProviders.apple,
                //     SocialProviders.google,
                //   ],
                //   colored: true,
                //   redirectUrl:
                //       kIsWeb ? null : 'io.supabase.flutter://reset-callback/',
                //   onSuccess: (Session response) {
                //     // do something, for example: navigate('home');
                //   },
                //   onError: (error) {
                //     // do something, for example: navigate("wait_for_email");
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
