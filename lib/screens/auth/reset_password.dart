import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _passwordVisible = true;
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
                    // await supabase.auth.updateUser({password: new_password});
                  } else {

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
