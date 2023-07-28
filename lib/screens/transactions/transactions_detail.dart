import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/models/transaction/transaction_items_model.dart';
import 'package:unimarket/screens/homepage.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:unimarket/utilities/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/home_provider.dart';
import '../../controller/transaction_provider.dart';
import '../../models/transaction/transaction_model.dart';
import '../cart/xendit_webview.dart';

class TransactionDetail extends StatefulWidget {
  final int transactionId;
  final TransactionModel transactionData;
  const TransactionDetail(
      {Key? key, required this.transactionId, required this.transactionData})
      : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  bool? isLoading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    String? formattedUserAlamat =
        '${profileProvider.loggedUserData!.address?.alamat} ${profileProvider.loggedUserData!.address?.type} ${profileProvider.loggedUserData!.address?.city_name}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: FutureBuilder<List<TransactionItemsModel>>(
        future:
            transactionProvider.getTransactionItemDetail(widget.transactionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      //NANTI EXTRACT WIDGET
                      return ExpansionTile(
                          title: Text(snapshot.data![index].products!.name!),
                          children: [
                            SizedBox(
                              // color: Colors.grey[350],
                              width: double.infinity,
                              // height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //ROW 1
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            child: snapshot.data![index]
                                                        .products!.img_url ==
                                                    null
                                                ? const Icon(
                                                    Icons.broken_image_outlined)
                                                : Image.network(
                                                    snapshot.data![index]
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
                                                Text(snapshot.data![index]
                                                    .products!.name!),
                                                Text(snapshot.data![index]
                                                    .products!.category!),
                                                Text(
                                                  'Seller : ${snapshot.data![index].products!.profiles!.username!}',
                                                ),
                                                Text(
                                                    'Status Pesanan : ${snapshot.data![index].transactionItemStatus}'),
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
                                                  numberCurrency.format(snapshot
                                                      .data![index]
                                                      .products!
                                                      .price),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //ROW 2
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //TOMBOL REFUND
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              elevation: 0.5,
                                            ),
                                            onPressed:
                                                // snapshot.data![index].isCancelled ==
                                                //         true
                                                //     ? null
                                                //     :
                                                transactionProvider
                                                    .refundButtonState(
                                              isConfirmed: snapshot
                                                  .data![index].isConfirmed!,
                                              isCancelled: snapshot
                                                  .data![index].isConfirmed!,
                                              paymentStatus: widget
                                                  .transactionData
                                                  .transactionStatus!,
                                              transactionItemStatus: snapshot
                                                  .data![index]
                                                  .transactionItemStatus!,
                                              onPressed: () async {
                                                await myAlertDialog(
                                                  context: context,
                                                  title: 'Refund ?',
                                                  content:
                                                      'Ingin ajukan pengambalian dana sebesar ${numberCurrency.format(snapshot.data![index].products!.price)}?',
                                                  onCancel: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  onPressed: () async {
                                                    isLoading = true;
                                                    showGeneralDialog(
                                                      context: context,
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          loadingIndicator,
                                                    );
                                                    await transactionProvider
                                                        .refundTransactionItem(
                                                      transactionItemId:
                                                          snapshot
                                                              .data![index].id,
                                                      productPrice: snapshot
                                                          .data![index]
                                                          .products!
                                                          .price!,
                                                    );
                                                    isLoading = false;
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                    //BELUM DIIMPLEMENT!
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                    snackbar(
                                                      context,
                                                      'Berhasil Membatalkan, Silahkan Cek Saldo Untuk Pengembalian Dana',
                                                      Colors.black,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            child: const Text(
                                              'Refund',
                                            ),
                                          ),
                                        ),
                                      ),
                                      //TOMBOL UNDUH / KONFIRMASI
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: transactionProvider
                                                .buttonConfirmedState(
                                              isCancelled: snapshot
                                                  .data![index].isCancelled,
                                              isConfirmed: snapshot
                                                  .data![index].isConfirmed!,
                                              status: widget.transactionData
                                                  .transactionStatus!,
                                              onPressed: () async {
                                                if (snapshot.data![index]
                                                        .products!.category ==
                                                    'Produk Digital') {
                                                  await myAlertDialog(
                                                    context: context,
                                                    title:
                                                        'Unduh & Konfirmasi ?',
                                                    content:
                                                        'Apakah anda yakin ingin unduh dan konfirmasi pesanan? Dana sebesar ${numberCurrency.format(snapshot.data![index].products!.price)} akan diteruskan ke penjual.',
                                                    onCancel: () {
                                                      Navigator.pop(context);
                                                    },
                                                    onPressed: () async {
                                                      isLoading = true;
                                                      showGeneralDialog(
                                                        context: context,
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            loadingIndicator,
                                                      );
                                                      await transactionProvider
                                                          .confirmTransaction(
                                                        transactionItemId:
                                                            snapshot
                                                                .data![index]
                                                                .id,
                                                        productPrice: snapshot
                                                            .data![index]
                                                            .products!
                                                            .price,
                                                        productCategory:
                                                            snapshot
                                                                .data![index]
                                                                .products!
                                                                .category!,
                                                        sellerId: snapshot
                                                            .data![index]
                                                            .products!
                                                            .seller_id!,
                                                        productId: snapshot
                                                            .data![index]
                                                            .products!
                                                            .id!,
                                                        fileName: snapshot
                                                            .data![index]
                                                            .products!
                                                            .file_url,
                                                      );
                                                      isLoading = false;
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                  );
                                                } else {
                                                  await myAlertDialog(
                                                    context: context,
                                                    title:
                                                        'Unduh & Konfirmasi ?',
                                                    content:
                                                        'Apakah anda yakin mengonfirmasi pesanan? Dana sebesar ${numberCurrency.format(snapshot.data![index].products!.price)} akan diteruskan ke penjual.',
                                                    onCancel: () {
                                                      Navigator.pop(context);
                                                    },
                                                    onPressed: () async {
                                                      isLoading = true;
                                                      showGeneralDialog(
                                                        context: context,
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            loadingIndicator,
                                                      );
                                                      await transactionProvider
                                                          .confirmTransaction(
                                                        transactionItemId:
                                                            snapshot
                                                                .data![index]
                                                                .id,
                                                        productPrice: snapshot
                                                            .data![index]
                                                            .products!
                                                            .price,
                                                        productCategory:
                                                            snapshot
                                                                .data![index]
                                                                .products!
                                                                .category!,
                                                        sellerId: snapshot
                                                            .data![index]
                                                            .products!
                                                            .seller_id!,
                                                        productId: snapshot
                                                            .data![index]
                                                            .products!
                                                            .id!,
                                                        fileName: snapshot
                                                            .data![index]
                                                            .products!
                                                            .file_url,
                                                      );
                                                      isLoading = false;
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                      Navigator.pop(context);
                                                      snackbar(
                                                          context,
                                                          'Berhasil Konfirmasi & Unduh',
                                                          Colors.black);
                                                      setState(() {});
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                            child: snapshot.data![index]
                                                        .products!.category! ==
                                                    'Produk Digital'
                                                ? const Text('Unduh')
                                                : const Text(
                                                    'Konfirmasi Pesanan'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(8),
                                    ),
                                    onPressed: () async {
                                      try {
                                        await launchUrlString(
                                          'whatsapp://send?phone=62${snapshot.data![index].products!.profiles!.phone}&text=${Uri.parse('message')}',
                                          // 'https://api.whatsapp.com/send?phone=62${widget.snapshot.data![widget.index].profiles!.phone!.replaceAll('0', '')}',
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
                                    child: const Text('Hubungi Penjual'),
                                  ),
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
                            const Text('Status Pembayaran : '),
                            Text(widget.transactionData.transactionStatus!)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tanggal Pembelian : '),
                            Text(
                              DateFormat('d MMMM, yyyy - h:mm a').format(
                                DateTime.parse(
                                    widget.transactionData.createdAt!),
                              ),
                            )
                          ],
                        ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Link Pembayaran :'),
                            TextButton.icon(
                              icon: const Icon(Icons.payment),
                              label: const Text('Bayar'),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => XenditWebview(
                                        url: widget
                                            .transactionData.payment_url!),
                                  ),
                                );
                                // launchUrlString(
                                //   widget.transactionData.payment_url.toString(),
                                // );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //BUTTON BAWAH (KALAU BELUM DIBAYAR BISA DIKLIK, ELSE DISABLED!!)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              child: const Text('BATALKAN PESANAN'),
                              onPressed: transactionProvider
                                  .cancelTransactionButtonState(
                                paymentStatus:
                                    widget.transactionData.transactionStatus!,
                                onPressed: () async {
                                  await myAlertDialog(
                                    context: context,
                                    title: 'Batalkan Transaksi ?',
                                    content:
                                        'Apakah anda yakin ingin membatalkan transaksi? Semua produk di pesanan ini akan batalkan.',
                                    onCancel: () async {
                                      Navigator.pop(context);
                                    },
                                    onPressed: () async {
                                      isLoading = true;
                                      showGeneralDialog(
                                        context: context,
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            loadingIndicator,
                                      );
                                      await transactionProvider
                                          .cancelTransaction(
                                        invoicesId:
                                            widget.transactionData.invoicesId!,
                                      );
                                      isLoading = false;
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      Navigator.pop(context);
                                      homeProvider.changePage(2);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    },
                                  );
                                },
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return loadingIndicator;
          }
        },
      ),
    );
  }
}
