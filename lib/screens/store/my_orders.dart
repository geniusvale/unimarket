import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimarket/controller/store_provider.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/models/transaction/transaction_items_model.dart';
import 'package:unimarket/utilities/constants.dart';

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
      body: FutureBuilder<List<TransactionItemsModel>>(
        future: storeProvider.getMyOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].products!.name!,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pembeli : ${snapshot.data![index].profiles!.username!}',
                      ),
                      Text(
                        'Status Pesanan : ${snapshot.data![index].transactionItemStatus!}',
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        numberCurrency
                            .format(snapshot.data![index].products!.price),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == []) {
            return const Center(child: Text('Tidak Ada Pesanan'));
          } else {
            return loadingIndicator;
          }
        },
      ),
    );
  }
}
