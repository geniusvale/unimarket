import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/manage_shipment_receipt_provider.dart';
import 'package:unimarket/models/transaction/transaction_model.dart';
import 'package:unimarket/screens/admin/manage_shipment_receipt_detail.dart';

class ManageShipmentReceipt extends StatefulWidget {
  const ManageShipmentReceipt({Key? key}) : super(key: key);

  @override
  State<ManageShipmentReceipt> createState() => _ManageShipmentReceiptState();
}

class _ManageShipmentReceiptState extends State<ManageShipmentReceipt> {
  @override
  Widget build(BuildContext context) {
    final manageShipmentReceiptProvider =
        Provider.of<ManageShipmentReceiptProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Pengiriman & Resi Transaksi'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<List<TransactionModel>>(
          future: manageShipmentReceiptProvider
              .getAllTransactionIncludeProdukFisik(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child:
                    Text('Tidak Ada Transaksi Produk Fisik yang Sudah Dibayar'),
              );
            } else {
              return Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageShipmentReceiptDetail(
                              snapshot: snapshot.data![index],
                            ),
                          ),
                        ),
                        title: Text(
                          'Transaksi : ${snapshot.data![index].externalId!}',
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nomor Resi : ${snapshot.data?[index].resi ?? 'Resi Belum Diupdate'}',
                            ),
                            Text(
                              DateFormat('d MMMM, yyyy - h:mm a').format(
                                DateTime.parse(
                                  snapshot.data![index].createdAt!,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
