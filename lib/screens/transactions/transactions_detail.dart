import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/models/transaction/transaction_items_model.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/transaction_provider.dart';
import '../../models/transaction/transaction_model.dart';

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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      leading: snapshot.data![index].products!.img_url == null
                          ? const Icon(Icons.broken_image_outlined)
                          : Image.network(
                              snapshot.data![index].products!.img_url!,
                              width: 50,
                              height: 50,
                            ),
                      title: Text(snapshot.data![index].products!.name!),
                      subtitle: Text(
                          snapshot.data![index].products!.profiles!.username!),
                      trailing: Column(
                        children: [
                          Text(
                            numberCurrency
                                .format(snapshot.data![index].products!.price),
                          ),
                          SizedBox(
                            width: 110,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Konfirmasi\natau Unduh',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                formSpacer,
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
                Text('Status Pembayaran : ${widget.transactionData.status}'),
                Text(
                    'Tanggal Pembelian : ${DateFormat('d MMMM, yyyy - h:mm a').format(DateTime.parse(widget.transactionData.createdAt!))}'),
                ListTile(
                  title: const Text('Alamat Pengiriman'),
                  subtitle: Text(widget.transactionData.address!),
                ),
                //BUTTON BAWAH
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
                        child: const Text('Bayar Pesanan'),
                        onPressed: () async {
                          launchUrlString(
                            widget.transactionData.payment_url.toString(),
                          );
                          // final res = await xendit.getInvoice(
                          //     invoice_id: '64a38d94f4ac8563b807654b');
                          // print('HASIL GET ID $res');
                        },
                      ),
                    )
                  ],
                )
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
