import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;

import '../../controller/cart_provider.dart';
import '../../models/cart/cart_items/cart_items_model.dart';
import '../../utilities/constants.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
    this.snapshotData,
    this.subtotal,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();

  final List<CartItemsModel>? snapshotData;
  final int? subtotal;
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    final cartProvider =
        providers.Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  color: Colors.grey[300],
                  height: 35,
                  child: const Text(
                    'Rincian Produk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ListView.separated(
              itemCount: widget.snapshotData!.length,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 30,
                    height: 40,
                    child: Image.network(
                        widget.snapshotData![index].products!.img_url!),
                  ),
                  title: Text(widget.snapshotData![index].products!.name!),
                  subtitle:
                      Text(widget.snapshotData![index].products!.category!),
                  trailing: Text(
                    numberCurrency.format(
                      widget.snapshotData![index].products!.price,
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1),
                    const ListTile(
                      title: Text('Alamat Pengiriman (Jika Produk Fisik)'),
                      subtitle: Text(
                        'Jl.Kesambi Gg.Ledeng No.66 Kota Cirebon 45134 Jawa Barat, Indonesia',
                      ),
                      trailing: Icon(Icons.chevron_right_rounded),
                    ),
                    formSpacer,
                    const ListTile(
                      title: Text('Metode Pembayaran'),
                      subtitle: Text(
                        'Xendit Payment (Bank Transfer, EWallet, QRIS, Outlet)',
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ongkos Kirim : '),
                        Text(numberCurrency.format(0)),
                      ],
                    ),
                    //Jika ada barang fisik, maka hitung ongkos kirim nya! Buat fungsi IF nanti.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Jumlah : '),
                        Text('${widget.snapshotData!.length} Item'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          numberCurrency.format(widget.subtotal),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    formSpacer,
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
                            child: const Text(
                              'BUAT PESANAN',
                            ),
                            onPressed: () async {
                              await cartProvider.makeOrderAndPay(
                                snapshotData: widget.snapshotData!,
                                subtotal: widget.subtotal!,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
