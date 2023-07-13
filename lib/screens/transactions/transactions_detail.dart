import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/models/transaction/transaction_items_model.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/transaction_provider.dart';
import '../../models/transaction/transaction_model.dart';
import '../cart/xendit_webview.dart';

class TransactionDetail extends StatefulWidget {
  final int transactionId;
  final TransactionModel transactionData;
  const TransactionDetail(
      {Key? key, required this.transactionId, required this.transactionData})
      : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: FutureBuilder<List<TransactionItemsModel>>(
        future:
            transactionProvider.getTransactionItemDetail(widget.transactionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      //NANTI EXTRACT WIDGET
                      return SizedBox(
                        // color: Colors.grey[350],
                        width: double.infinity,
                        // height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //ROW 1
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: snapshot.data![index].products!
                                                  .img_url ==
                                              null
                                          ? const Icon(
                                              Icons.broken_image_outlined)
                                          : Image.network(
                                              snapshot.data![index].products!
                                                  .img_url!,
                                              width: 50,
                                              height: 50,
                                            ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot
                                              .data![index].products!.name!),
                                          Text(snapshot.data![index].products!
                                              .category!),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            numberCurrency.format(snapshot
                                                .data![index].products!.price),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //ROW 2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //TOMBOL UNDUH / KONFIRMASI
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: transactionProvider
                                          .buttonConfirmedState(
                                        isConfirmed:
                                            snapshot.data![index].isConfirmed!,
                                        status: widget.transactionData.status!,
                                        onPressed: () async {
                                          await transactionProvider
                                              .confirmTransaction(
                                            transactionItemId:
                                                snapshot.data![index].id,
                                            productPrice: snapshot
                                                .data![index].products!.price,
                                            sellerId: snapshot.data![index]
                                                .products!.seller_id!,
                                          );
                                          setState(() {});
                                        },
                                      ),
                                      child: snapshot.data![index].products!
                                                  .category! ==
                                              'Produk Digital'
                                          ? const Text('Unduh')
                                          : const Text('Konfirmasi Pesanan'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                              ),
                              onPressed: () async {
                                try {
                                  await launchUrlString(
                                    'whatsapp://send?phone=${snapshot.data![index].products!.profiles!.phone}&text=${Uri.parse('message')}',
                                    // 'https://api.whatsapp.com/send?phone=62${widget.snapshot.data![widget.index].profiles!.phone!.replaceAll('0', '')}',
                                    mode: LaunchMode.externalApplication,
                                  );
                                } catch (e) {
                                  snackbar(
                                    context,
                                    e.toString(),
                                    Colors.black,
                                  );
                                }
                              },
                              child: const Text('Hubungi Penjual'),
                            ),
                            // const Divider(height: 1),
                          ],
                        ),
                      );
                    },
                  ),
                  // formSpacer,
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
                  //CONTAINER ISI RINCIAN
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Status Pembayaran : '),
                            Text(widget.transactionData.status!)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tanggal Pembelian : '),
                            Text(
                              DateFormat('d MMMM, yyyy - h:mm a').format(
                                DateTime.parse(
                                    widget.transactionData.createdAt!),
                              ),
                            )
                          ],
                        ),
                        const Text('Alamat Pengiriman :'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Link Pembayaran :'),
                            TextButton.icon(
                              icon: const Icon(Icons.payment),
                              label: const Text('Bayar'),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => XenditWebview(
                                        url: widget
                                            .transactionData.payment_url!),
                                  ),
                                );
                                // launchUrlString(
                                //   widget.transactionData.payment_url.toString(),
                                // );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //BUTTON BAWAH
                  // BlueButton()
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
