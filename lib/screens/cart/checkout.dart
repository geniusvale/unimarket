import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
              separatorBuilder: (context, index) => const Divider(),
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
                                await supabase
                                    .from('transactions_item')
                                    .insert({
                                  'users_id': supabase.auth.currentUser!.id,
                                  'products_id': '${cartItems.product_id}',
                                  'transactions_id': '${transactionId['id']}',
                                });
                              }
                              //After adding, delete every cartItems in DB!
                              for (var delCartItems in widget.snapshotData!) {
                                await supabase
                                    .from('cart_items')
                                    .delete()
                                    .match({
                                  'id': delCartItems.id,
                                });
                                print(delCartItems);
                              }
                              //Harus SetState(?)
                              //PAY WITH XENDIT
                              var res = await xendit.invoke(
                                endpoint:
                                    'POST https://api.xendit.co/v2/invoices',
                                headers: {'for-user-id': ''},
                                parameters: {
                                  'external_id': 'invoice-timestamp',
                                  'amount': widget.subtotal,
                                  'payer_email':
                                      supabase.auth.currentUser!.email,
                                  'description': "Invoice Demo #123"
                                },
                              );
                              print(res);
                              final paymentUrl = res['invoice_url'];
                              print('Hasil PAYMENT URL $paymentUrl');

                              //Tambahkan Invoice ID ke Transactions (Belum diimplement)

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
                                  mode:
                                      LaunchMode.inAppWebView, //enables WebView
                                  webViewConfiguration:
                                      const WebViewConfiguration(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
