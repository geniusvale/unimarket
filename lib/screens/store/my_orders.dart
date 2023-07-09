import 'package:flutter/material.dart';
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].products!.name!,
                  ),
                  subtitle: Text(snapshot.data![index].profiles!.username!),
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
