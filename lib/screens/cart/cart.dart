import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/cart_provider.dart';

import '../../utilities/constants.dart';

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

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
    this.snapshotData,
    this.subtotal,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();

  final List<Map<String, dynamic>>? snapshotData;
  final int? subtotal;
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  formSpacer,
                  ListView.separated(
                    itemCount: widget.snapshotData!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                        title: Text(
                            widget.snapshotData![index]['products']['name']),
                        trailing: Text(
                          numberCurrency.format(
                            widget.snapshotData![index]['products']['price'],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                  formSpacer,
                  const ListTile(
                    title: Text('Alamat Pengiriman (Jika Produk Fisik)'),
                    subtitle: Text(
                      'Jl.Kesambi Gg.Ledeng No.66 Kota Cirebon 45134 Jawa Barat, Indonesia',
                    ),
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                  formSpacer,
                  RadioListTile(
                    selected: true,
                    value: 0,
                    groupValue: 0,
                    onChanged: (val) {},
                    title: const Text('Metode Pembayaran'),
                    subtitle: const Text(
                      'Xendit Payment (Bank Transfer, EWallet, QRIS, Outlet)',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ongkos Kirim : ${numberCurrency.format(0)}'),
                //Jika ada barang fisik, maka hitung ongkos kirim nya! Buat fungsi IF nanti.
                Text(
                  'Jumlah Barang : ${widget.snapshotData!.length}',
                  textAlign: TextAlign.right,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Subtotal : ${numberCurrency.format(widget.subtotal)}',
                        textAlign: TextAlign.right,
                      ),
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
                          //Make new transactions to db
                          await supabase.from('transactions').insert({
                            'users_id': supabase.auth.currentUser!.id,
                            'address': '',
                            'phone': '',
                            'email': supabase.auth.currentUser!.email,
                            'total_price': widget.subtotal,
                            'payment_url': '',
                            'status': 'UNPAID',
                          });
                          //informasi alamat nomor telepon dll lengkapi dihalaman edit profil.
                          //redirect ke halaman tsb.
                          //GET Transactions ID yang baru dibuat. berdasarkan timestamps?? or what??
                          //~~~~~
                          final dateTime = DateTime.now();
                          final transactionId = await supabase
                              .from('transactions')
                              .select('id, created_at')
                              .eq('users_id', supabase.auth.currentUser!.id)
                              .order('created_at', ascending: false)
                              .limit(1)
                              .single();
                          //Belum Bener, karena gak bisa ambil 1 value yang baru dibuat jika ada lebih dari 1 data
                          //Sudah benat
                          print('GET TransactionID $transactionId');
                          //ADD every items to transactionItems in db using looping
                          for (var cartItems in widget.snapshotData!) {
                            //Karena perulangan maka yang dikirim JSON, jadi value harus string dahulu!
                            print(cartItems);
                            await supabase.from('transactions_item').insert({
                              'users_id': supabase.auth.currentUser!.id,
                              'products_id': '${cartItems['product_id']}',
                              'transactions_id': '${transactionId['id']}',
                            });
                          }
                          //After adding, delete every cartItems in DB!
                          for (var delCartItems in widget.snapshotData!) {
                            await supabase.from('cart_items').delete().match({
                              'id': delCartItems['id'],
                            });
                            print(delCartItems);
                          }
                          //Harus SetState(?)
                          //PAY WITH XENDIT
                          var res = await xendit.invoke(
                            endpoint: 'POST https://api.xendit.co/v2/invoices',
                            headers: {'for-user-id': ''},
                            parameters: {
                              'external_id': 'invoice-timestamp',
                              'amount': widget.subtotal,
                              'payer_email': supabase.auth.currentUser!.email,
                              'description': "Invoice Demo #123"
                            },
                          );
                          print(res);
                          final paymentUrl = res['invoice_url'];
                          print('Hasil PAYMENT URL $paymentUrl');

                          await supabase
                              .from('transactions')
                              .update({'payment_url': paymentUrl}).eq(
                            'id',
                            '${transactionId['id']}',
                          );

                          //LAUNCH TO WEBVIEW
                          try {
                            await launchUrlString(
                              paymentUrl,
                              mode: LaunchMode.inAppWebView, //enables WebView
                              webViewConfiguration: const WebViewConfiguration(
                                enableJavaScript: true,
                              ),
                            );
                          } catch (e) {
                            rethrow;
                          }
                          //Kembali ke halaman dan refresh dari webview???
                          //Mengatur Callback???
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
