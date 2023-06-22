import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;

import '../controller/cart_provider.dart';

import '../utilities/constants.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider =
        providers.Provider.of<CartProvider>(context, listen: false);
    int sum = 0; //Pakai double 0.0 (?)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: cartProvider.getMyCart(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    //Buat Model CartItems(?)
                    final harga =
                        snapshot.data?[index]['products']['price'].toString();
                    sum += int.parse(harga!); //Pakai double.parse (?)

                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text(snapshot.data?[index]['products']['name']),
                      subtitle: Text(harga),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Subtotal : ${numberCurrency.format(sum)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Button BAYAR BAYAR
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(color: Colors.white),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('BAYAR NGAB'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
