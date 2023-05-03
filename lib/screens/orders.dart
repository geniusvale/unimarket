import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
