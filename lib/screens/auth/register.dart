import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/controller/auth_provider.dart';
import 'package:unimarket/screens/auth/login.dart';

import '../../utilities/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordVisible = true;
  bool kIsWeb = true;
  final formKey = GlobalKey<FormState>();
  final usernameC = TextEditingController();
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
                formSpacer,
                TextFormField(
                  controller: usernameC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: borderRadiusStd),
                    hintText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                formSpacer,
                TextFormField(
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: borderRadiusStd),
                    hintText: 'Email',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => !EmailValidator.validate(value!)
                      ? 'Format Email Salah!'
                      : null,
                ),
                formSpacer,
                TextFormField(
                  controller: passwordC,
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
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password tidak boleh kurang dari 6 karakter!';
                    }
                    return null;
                  },
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
                          if (formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            AuthProvider().register(
                              usernameC.text,
                              emailC.text,
                              passwordC.text,
                            );
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
                formSpacer,
                Container(
                  padding: formPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                          child: const Text('Login')),
                    ],
                  ),
                )
                // SupaEmailAuth(
                //   authAction: SupaAuthAction.signUp,
                //   redirectUrl:
                //       kIsWeb ? null : 'io.supabase.flutter://reset-callback/',
                //   onSuccess: (AuthResponse response) {
                //     // do something, for example: navigate('home');
                //   },
                //   onError: (error) {
                //     // do something, for example: navigate("wait_for_email");
                //   },
                //   metadataFields: [
                //     MetaDataField(
                //       prefixIcon: const Icon(Icons.person),
                //       label: 'Username',
                //       key: 'username',
                //       validator: (val) {
                //         if (val == null || val.isEmpty) {
                //           return 'Please enter something';
                //         }
                //         return null;
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
