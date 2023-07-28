import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimarket/models/transaction/transaction_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';

class MyOrdersDetail extends StatefulWidget {
  MyOrdersDetail({Key? key, required this.snapshot}) : super(key: key);

  TransactionModel snapshot;

  @override
  State<MyOrdersDetail> createState() => _MyOrdersDetailState();
}

class _MyOrdersDetailState extends State<MyOrdersDetail> {
  bool? isLoading;
  final resiC = TextEditingController();
  int? total;

  @override
  void initState() {
    resiC.text = widget.snapshot.resi ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = widget.snapshot;
    String? formattedUserAlamat =
        '${snapshot.address?.alamat} ${snapshot.address?.type} ${snapshot.address?.city_name}';
    // final MyOrdersDetailProvider =
    //     Provider.of<ManageShipmentReceiptProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.transactionItems!.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                //NANTI EXTRACT WIDGET
                return ExpansionTile(
                    title: Text(
                      '${snapshot.transactionItems![index].products?.name}',
                    ),
                    children: [
                      SizedBox(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: snapshot.transactionItems![index]
                                                  .products?.img_url ==
                                              null
                                          ? const Icon(
                                              Icons.broken_image_outlined)
                                          : Image.network(
                                              snapshot.transactionItems![index]
                                                  .products!.img_url!,
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
                                          Text(snapshot.transactionItems![index]
                                                  .products?.name ??
                                              ''),
                                          Text(snapshot.transactionItems![index]
                                                  .products?.category ??
                                              ''),
                                          Text(
                                            'Seller : ${snapshot.transactionItems![index].products?.profiles!.username!}',
                                          ),
                                          Text(
                                              'Status Pesanan : ${snapshot.transactionItems![index].transactionItemStatus}'),
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
                                            numberCurrency.format(
                                              snapshot.transactionItems![index]
                                                      .products?.price ??
                                                  0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //ROW 2

                            // const Divider(height: 1),
                          ],
                        ),
                      ),
                    ]);
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
                      'Rincian Transaksi',
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
                      const Text('Pembeli : '),
                      Text(snapshot.profiles!.username!)
                    ],
                  ),
                  formSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: Text('Alamat Pengiriman : ')),
                      Expanded(
                        child: Text(
                          formattedUserAlamat,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  formSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal Pembelian : '),
                      Text(
                        DateFormat('d MMMM, yyyy - h:mm a').format(
                          DateTime.parse(snapshot.createdAt!),
                        ),
                      )
                    ],
                  ),
                  formSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status Pembayaran : '),
                      Text(snapshot.transactionStatus!)
                    ],
                  ),
                  formSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ongkos Kirim : '),
                      Text(numberCurrency.format(snapshot.ongkir))
                    ],
                  ),
                  formSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Informasi Kurir : '),
                      Expanded(
                          child: Text(
                        snapshot.shippingInfo ?? '-',
                        textAlign: TextAlign.right,
                      ))
                    ],
                  ),
                  formSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nomor Resi : '),
                      Text(snapshot.resi ?? 'Nomor Resi Belum Tersedia')
                    ],
                  ),
                  formSpacer,
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                          ),
                          onPressed: () async {
                            try {
                              await launchUrlString(
                                'whatsapp://send?phone=${snapshot.profiles!.phone}&text=${Uri.parse('message')}',
                                // 'https://api.whatsapp.com/send?phone=62${widget.snapshot.transactionItems![widget.index].profiles!.phone!.replaceAll('0', '')}',
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
                          child: const Text('Hubungi Pembeli'),
                        ),
                      ),
                    ],
                  ),
                  formSpacer,
                ],
              ),
            ),
            formSpacer,
          ],
        ),
      ),
    );
  }
}
