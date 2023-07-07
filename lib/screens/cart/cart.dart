import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:unimarket/models/cart/cart_items/cart_items_model.dart';

import '../../controller/cart_provider.dart';

import '../../utilities/constants.dart';
import 'checkout.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
      body: FutureBuilder<List<CartItemsModel>>(
        future: cartProvider.getMyCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<CartItemsModel> data = snapshot.data!;
            int newSubtotal = cartProvider.jumlahkanSubtotal(data);
            subtotal = newSubtotal;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //Buat Model CartItems(?)
                      final harga =
                          snapshot.data?[index].products!.price.toString();
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 1,
                              onPressed: (context) async {
                                await cartProvider.deleteCartItems(
                                  snapshot.data![index].id,
                                );
                                setState(() {});
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete_outline,
                              label: 'Hapus',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            width: 30,
                            height: 40,
                            child: Image.network(
                                snapshot.data![index].products!.img_url!),
                          ),
                          title: Text(snapshot.data![index].products!.name!),
                          subtitle: Text(
                            snapshot.data![index].products!.category!,
                          ),
                          trailing: Text(
                            numberCurrency
                                .format(snapshot.data![index].products!.price!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal : ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              numberCurrency.format(subtotal),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Button BAYAR BAYAR
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Checkout(
                                        snapshotData: data,
                                        subtotal: subtotal,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return loadingIndicator;
          }
        },
      ),
    );
  }
}
