import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    //Future Builder Sementara Untuk Wishlist, Nanti Diganti Get Ke Tabel Cart
    //Kasih Blocked Action Jika Unauthenticated
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return const ListTile();
        },
      ),
    );
  }
}
