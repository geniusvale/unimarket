import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool kIsWeb = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SupaEmailAuth(
              authAction: SupaAuthAction.signIn,
              redirectUrl:
                  kIsWeb ? null : 'io.supabase.flutter://reset-callback/',
              onSuccess: (AuthResponse response) {
                // do something, for example: navigate('home');
              },
              onError: (error) {
                // do something, for example: navigate("wait_for_email");
              },
            ),
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
    );
  }
}
