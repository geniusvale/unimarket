import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/screens/cart/xendit_webview.dart';

import '../../controller/profile_provider.dart';
import '../../controller/store_provider.dart';
import '../../utilities/constants.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Withdraw'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              // color: Colors.grey,
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saldo : ${numberCurrency.format(profileProvider.loggedUserData.saldo ?? 0)}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    child: const Text('Tarik Dana'),
                    onPressed: () async {
                      if (profileProvider.loggedUserData.saldo == 0) {
                        return snackbar(
                            context, 'Saldo Tidak Cukup!', Colors.red);
                      } else {
                        await storeProvider.withdraw(
                          context: context,
                          username: profileProvider.loggedUserData.username!,
                          amount: profileProvider.loggedUserData.saldo!,
                        );
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Riwayat Penarikan :',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: storeProvider.getWithdrawHistory(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index]['external_id']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              numberCurrency
                                  .format(snapshot.data![index]['amount']),
                            ),
                            Text(snapshot.data![index]['status'] ?? 'Error'),
                          ],
                        ),
                        trailing: TextButton.icon(
                          icon: const Icon(Icons.chevron_right_rounded),
                          label: const Text('Klaim'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => XenditWebview(
                                    url: snapshot.data![index]['payout_url']),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak Ada Data!'),
                  );
                } else {
                  return loadingIndicator;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
