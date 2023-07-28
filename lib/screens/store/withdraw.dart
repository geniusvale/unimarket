import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/screens/cart/xendit_webview.dart';

import '../../controller/profile_provider.dart';
import '../../controller/store_provider.dart';
import '../../models/withdraw/withdraw_model.dart';
import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  bool? isLoading;
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HEADER
              Container(
                padding: const EdgeInsets.all(16),
                // color: Colors.grey,
                width: double.infinity,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saldo : ${numberCurrency.format(profileProvider.loggedUserData!.saldo ?? 0)}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      child: const Text('Tarik Dana'),
                      onPressed: () async {
                        if (profileProvider.loggedUserData!.saldo == 0 ||
                            profileProvider.loggedUserData!.saldo! < 20000) {
                          return snackbar(
                              context,
                              'Saldo Tidak Cukup! Minimal Penarikan Rp.20,000',
                              Colors.red);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi Penarikan Dana'),
                                content: SizedBox(
                                  width: double.infinity,
                                  height: 160,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Anda akan menarik saldo sejumlah :\n${numberCurrency.format(profileProvider.loggedUserData!.saldo! - 2500)}'),
                                      Text(
                                          'Biaya penarikan : ${numberCurrency.format(2500)}'),
                                      formSpacer,
                                      const Text(
                                          'Harap Cek Email untuk Secret Password saat Penarikan Dana!!'),
                                      formSpacer,
                                      const Text('Lanjutkan?'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Batal')),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        isLoading = true;
                                        showGeneralDialog(
                                          context: context,
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              loadingIndicator,
                                        );
                                        await storeProvider.withdraw(
                                          context: context,
                                          isSeller: profileProvider
                                              .loggedUserData!.isSeller!,
                                          username: profileProvider
                                              .loggedUserData!.username!,
                                          amount: profileProvider
                                                  .loggedUserData!.saldo! -
                                              2500,
                                        );
                                        await profileProvider
                                            .getProfileDataFromAuth();
                                        isLoading = false;
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      } catch (e) {
                                        isLoading = false;
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        snackbar(context, e.toString(),
                                            Colors.black);
                                      }
                                    },
                                    child: const Text('Ya'),
                                  ),
                                ],
                              );
                            },
                          );

                          // setState(() {});
                        }
                      },
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Riwayat Penarikan :',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder<List<WithdrawModel>>(
                future: storeProvider.getWithdrawHistory(),
                builder: (context, snapshot) {
                  print(snapshot.data);
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
                      child: Text('Tidak Ada Riwayat Penarikan'),
                    );
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].external_id!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                numberCurrency
                                    .format(snapshot.data![index].amount),
                              ),
                              Text(snapshot.data![index].status ?? 'Error'),
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
                                      url: snapshot.data![index].payout_url!),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
