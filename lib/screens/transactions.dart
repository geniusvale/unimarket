import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    //Future Builder Sementara Untuk Wishlist, Nanti Diganti Get Ke Tabel Cart
    //Kasih Blocked Action Jika Unauthenticated
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Orders'),
      // ),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return const ListTile();
        },
      ),
    );
  }
}
