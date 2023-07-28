import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/transaction_provider.dart';
import 'package:unimarket/models/transaction/transaction_model.dart';
import 'package:unimarket/screens/transactions/transactions_detail.dart';
import 'package:unimarket/utilities/constants.dart';

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
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: FutureBuilder<List<TransactionModel>>(
                future: transactionProvider.getTransaction(),
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
                      child: Text('Tidak Ada Transaksi'),
                    );
                  } else {
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final date =
                            DateTime.parse(snapshot.data![index].createdAt!);
                        return ListTile(
                          isThreeLine: true,
                          // leading: CircleAvatar(
                          //   maxRadius: 32,
                          //   backgroundColor: Colors.transparent,
                          //   child: Text(
                          //     DateFormat('d\nMMM yy').format(date),
                          //     maxLines: 2,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       fontSize: 12,
                          //       color: Colors.grey[700],
                          //     ),
                          //   ),
                          // ),
                          title: Text('#${snapshot.data![index].externalId}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Status : ${snapshot.data![index].transactionStatus!}'),
                              Text(DateFormat('d MMM yyyy').format(date)),
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                numberCurrency
                                    .format(snapshot.data![index].total_price),
                              ),
                              Text(
                                  '${snapshot.data![index].quantity ?? 0} Item'),
                            ],
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
                          onLongPress: () {},
                        );
                      },
                    );
                  }
                },
              ),
            ),
    );
  }
}
