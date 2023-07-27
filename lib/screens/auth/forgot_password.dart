import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/utilities/widgets.dart';

import '../../utilities/constants.dart';

//BELUM DIIMPLEMENT

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailC,
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
              BlueButton(
                teks: 'Kirim Link Reset Password',
                padding: 0,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Container(
                          child: const Text(
                              'Silahkan Cek Email & Folder Spam Jika Tidak Ada Untuk Link Reset!'),
                        ),
                      ),
                    );
                    await supabase.auth.resetPasswordForEmail(
                      emailC.text,
                      redirectTo: 'com.example.unimarket/resetpassword',
                    );
                  } else {
                    null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
