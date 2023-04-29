import 'package:flutter/material.dart';

class BlockedAuth extends StatelessWidget {
  const BlockedAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Anda Harus Login'),
        content: const SizedBox(
          width: 100,
          height: 50,
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali')),
          ElevatedButton(onPressed: () {}, child: const Text('Login')),
        ],
      ),
    );
  }
}
