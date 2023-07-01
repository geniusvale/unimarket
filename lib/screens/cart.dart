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
  // int sum = 0; //Pakai double 0.0 (?)
  int subtotal = 0;
  int newSubtotal = 0;

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
            List<Map<String, dynamic>> data = snapshot.data!;
            int newSubtotal = cartProvider.jumlahkanSubtotal(data);
            subtotal = newSubtotal;
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
                            leading: CircleAvatar(
                              child: Text(index.toString()),
                            ),
                            title:
                                Text(snapshot.data?[index]['products']['name']),
                            subtitle: Text(
                              snapshot.data?[index]['products']['category'],
                            ),
                            trailing: Text(
                              numberCurrency.format(
                                  snapshot.data?[index]['products']['price']),
                            ),
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
                          // 'Subtotal : ${numberCurrency.format(sum)}',
                          'Subtotal : ${numberCurrency.format(subtotal)}',
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
                                child: const Text('CHECKOUT'),
                                onPressed: () async {
                                  //Make new transactions to db
                                  // await supabase.from('transactions').insert({
                                  //   'users_id': supabase.auth.currentUser!.id,
                                  //   'address': '',
                                  //   'phone': '',
                                  //   'email': supabase.auth.currentUser!.email,
                                  //   'total_price': subtotal,
                                  //   'payment_url': '',
                                  //   'status': '',
                                  // });
                                  //informasi alamat nomor telepon dll lengkapi dihalaman edit profil.
                                  //redirect ke halaman tsb.
                                  //GET Transactions ID yang baru dibuat. berdasarkan timestamps?? or what??
                                  //~~~~~
                                  // await supabase
                                  //     .from('transactions')
                                  //     .select('id')
                                  //     .eq('users_id',
                                  //         supabase.auth.currentUser!.id)
                                  //     .single();
                                  //ADD every items to transactionItems in db using looping
                                  for (var cartItems in snapshot.data!) {
                                    // await supabase
                                    //     .from('transactions_item')
                                    //     .insert({
                                    //       'users_id' : supabase.auth.currentUser!.id,
                                    //       'products_id' : cartItems['product_id'],
                                    //       'transactions_id' : ''
                                    //     });
                                    print(cartItems);
                                  }
                                  //After adding, delete every cartItems in DB!
                                  // for (var delCartItems in snapshot.data!) {
                                  //   await supabase
                                  //       .from('cart_items')
                                  //       .delete()
                                  //       .match({
                                  //     'id': delCartItems['id'],
                                  //   });
                                  //   print(delCartItems);
                                  // }
                                },
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
