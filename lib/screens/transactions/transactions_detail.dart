import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/utilities/constants.dart';

import '../../controller/transaction_provider.dart';

class TransactionDetail extends StatefulWidget {
  final int transactionId;
  const TransactionDetail({Key? key, required this.transactionId})
      : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future:
            transactionProvider.getTransactionItemDetail(widget.transactionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['products']['name']),
                  trailing: Text(
                    numberCurrency
                        .format(snapshot.data![index]['products']['price']),
                  ),
                );
              },
            );
          } else {
            return loadingIndicator;
          }
        },
      ),
    );
  }
}
