import 'package:flutter/material.dart';
import 'package:unimarket/screens/auth/login.dart';
import 'package:unimarket/utilities/constants.dart';

import '../controller/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Profile')),
          formSpacer,
          ElevatedButton(
            onPressed: () async {
              await AuthProvider().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
