import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/transaction_provider.dart';
import 'package:unimarket/models/transaction/transaction_model.dart';
import 'package:unimarket/screens/transactions/transactions_detail.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/auth_provider.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      body: authProvider.unAuthorized
          ? const Center(child: Text('Tidak Ada Transaksi'))
          : FutureBuilder<List<TransactionModel>>(
              future: transactionProvider.getTransaction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        isThreeLine: true,
                        leading: const Icon(Icons.receipt_long),
                        title: Text(
                            'Transaction ID : ${snapshot.data![index].id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![index].status!),
                            Text(snapshot.data![index].createdAt!)
                          ],
                        ),
                        trailing: Text(
                          numberCurrency
                              .format(snapshot.data![index].total_price),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TransactionDetail(
                                  transactionId: snapshot.data![index].id,
                                  transactionData: snapshot.data![index],
                                );
                              },
                            ),
                          );
                        },
                        onLongPress: () {
                          
                        },
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
