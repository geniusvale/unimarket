import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;
import 'package:flutter_slidable/flutter_slidable.dart';

import '../controller/cart_provider.dart';

import '../utilities/constants.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int sum = 0; //Pakai double 0.0 (?)
  @override
  Widget build(BuildContext context) {
    final cartProvider =
        providers.Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: cartProvider.getMyCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                        final harga = snapshot.data?[index]['products']['price']
                            .toString();
                        // for (var i = 0; i < count; i++) {}
                        // cartProvider.jumlahkanSubtotal(harga!, sum);
                        sum += int.parse(harga!); //Pakai double.parse (?)
                        print(sum);
                        // setState(() {});
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (context) {
                                  cartProvider.deleteCartItems(
                                    snapshot.data?[index]['id'],
                                  );
                                  //Data belum reload kelau belum REBUILD!!
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline,
                                label: 'Hapus',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(),
                            title:
                                Text(snapshot.data?[index]['products']['name']),
                            subtitle: Text(harga),
                          ),
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
                          // sum.toString(),
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
                                  textStyle:
                                      const TextStyle(color: Colors.white),
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
              ),
            );
          } else {
            return loadingIndicator;
          }
        },
      ),
    );
  }
}
