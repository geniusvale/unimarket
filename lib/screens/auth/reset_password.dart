import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';

//BELUM DIIMPLEMENT

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final resetTokenC = TextEditingController();
  bool _passwordVisible = true;
  bool? isLoading;
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
                controller: resetTokenC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: borderRadiusStd),
                  hintText: 'Reset Token',
                ),
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Token tidak sesuai!';
                  }
                  return null;
                },
              ),
              formSpacer,
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
                        ? SvgPicture.asset('assets/icons/eye.svg',
                            color: Colors.grey)
                        : SvgPicture.asset('assets/icons/eye-crossed.svg',
                            color: Colors.grey),
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
              BlueButton(
                teks: 'Reset Password',
                padding: 0,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          loadingIndicator,
                    );
                    try {
                      final recovery = await supabase.auth.verifyOTP(
                        email: emailC.text,
                        token: resetTokenC.text,
                        type: OtpType.recovery,
                      );
                      print(recovery);
                      await supabase.auth.updateUser(
                        UserAttributes(password: passwordC.text),
                      );
                      isLoading = false;
                      Navigator.of(context, rootNavigator: true).pop();
                      await snackbar(
                          context,
                          'Berhasil Ubah Password, Silahkan Login Kembali',
                          Colors.black);
                    } catch (e) {
                      snackbar(context, e.toString(), Colors.black);
                    }
                  } else {
                    snackbar(context, 'Isi dengan Benar!', Colors.black);
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
