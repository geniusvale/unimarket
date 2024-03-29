import 'package:flutter/material.dart';
import 'package:unimarket/screens/store/my_orders.dart';

import 'my_product.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Toko Anda'),
          actions: [
            IconButton(
              onPressed: () async {
                setState(() {});
              },
              icon: const Icon(Icons.refresh_rounded),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Produkmu'),
              Tab(text: 'Pesanan'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyProduct(),
            MyOrders(),
          ],
        ),
      ),
    );
  }
}
