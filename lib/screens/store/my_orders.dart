import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimarket/controller/store_provider.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/screens/store/my_orders_detail.dart';

import '../../models/transaction/transaction_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    final storeProvider =
        providers.Provider.of<StoreProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder<List<TransactionModel>>(
        future: storeProvider.getMyOrder(),
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
              child: Text('Tidak Ada Pesanan dari Toko Anda'),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyOrdersDetail(snapshot: snapshot.data![index]),
                      ),
                    );
                  },
                  title: Text(
                    snapshot.data![index].externalId!,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pembeli : ${snapshot.data![index].profiles!.username!}',
                      ),
                      Text(
                        'Status Pesanan : ${snapshot.data![index].transactionStatus!}',
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Text(
                      //   numberCurrency
                      //       .format(snapshot.data![index].products!.price),
                      //   style: const TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        DateFormat('dd MMMM yy').format(
                          DateTime.parse(snapshot.data![index].createdAt!),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
