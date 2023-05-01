import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/controller/auth_provider.dart';
import 'package:unimarket/screens/auth/login.dart';

import '../utilities/constants.dart';
import 'product_provider.dart';

class StoreProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final descC = TextEditingController();
  int randomNumber = Random().nextInt(999);
  int tabIndex = 0;

  //WIDGET Menampilkan Detail Produk Di Toko, dengan BottomSheet
  void showDetailProduct(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                formSpacer,
                Center(child: handleBar),
                formSpacer,
                Center(
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:
                        'https://picsum.photos/id/${index + randomNumber}/200/200',
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return CircularProgressIndicator(
                        value: downloadProgress.progress,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const SizedBox(
                        height: 50,
                        child: Icon(
                          Icons.broken_image_outlined,
                        ),
                      );
                    },
                  ),
                ),
                formSpacer,
                Text(
                  snapshot.data[index]['name'],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Rp ${snapshot.data[index]['price'].toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(snapshot.data[index]['desc'] ?? 'Tidak Ada Deskripsi'),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          try {
                            if (AuthProvider().unAuthorized == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            } else {
                              final user = supabase.auth.currentUser;
                              ProductsProvider().addToWishlist(
                                usersId: user!.id,
                                productId: snapshot.data[index]['id'],
                              );
                            }
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        icon: SvgPicture.asset('assets/icons/heart.svg'),
                        label: const Text('Save'),
                      ),
                      formSpacer,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[900],
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(color: Colors.white),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (AuthProvider().unAuthorized == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            } else {
                              return;
                            }
                          },
                          child: const Text('Tambah Ke Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //WIDGET Menampilkan Tambah Produk di Toko, dengan BottomSheet
  void showAddProduct(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: formPadding,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: const BoxDecoration(
                        borderRadius: borderRadiusStd,
                        color: Colors.grey,
                      ),
                    ),
                    formSpacer,
                    TextFormField(
                      controller: nameC,
                      decoration: formDecor(hint: 'Nama Produk'),
                    ),
                    formSpacer,
                    TextFormField(
                      controller: priceC,
                      keyboardType: TextInputType.number,
                      decoration: formDecor(hint: 'Harga'),
                    ),
                    formSpacer,
                    TextFormField(
                      controller: descC,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      decoration: formDecor(hint: 'Deskripsi'),
                    ),
                    formSpacer,
                    ElevatedButton(
                      onPressed: () async {
                        ProductsProvider().addProduct(
                          name: nameC.text,
                          desc: descC.text,
                          price: int.parse(priceC.text),
                        );
                        nameC.clear();
                        priceC.clear();
                        descC.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('ADD PRODUCT'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //WIDGET Menampilkan Update Produk di Toko, dengan BottomSheets
  void showUpdateProduct(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: formPadding,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Column(
                  children: [
                    handleBar,
                    formSpacer,
                    TextFormField(
                      controller: nameC,
                      decoration: formDecor(
                        hint: snapshot.data![index]['name'],
                      ),
                    ),
                    formSpacer,
                    TextFormField(
                      controller: priceC,
                      decoration: formDecor(
                        hint: snapshot.data![index]['price'].toString(),
                      ),
                    ),
                    formSpacer,
                    TextFormField(
                      controller: descC,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      decoration: formDecor(
                        hint: snapshot.data?[index]['desc'] ??
                            'Tidak Ada Deskripsi',
                      ),
                    ),
                    formSpacer,
                    ElevatedButton(
                      onPressed: () async {
                        await ProductsProvider().editProduct(
                          name: nameC.text,
                          price: int.parse(priceC.text),
                          desc: descC.text,
                          currentName: snapshot.data![index]['name'],
                          currentPrice:
                              snapshot.data![index]['price'].toString(),
                          currentDesc: snapshot.data![index]['desc'],
                        );
                        nameC.clear();
                        priceC.clear();
                        descC.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //WIDGET Menampilkan Dialog Hapus Produk di Toko
  showDeleteProduct(BuildContext context, AsyncSnapshot snapshot, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                ProductsProvider().deleteProduct(
                  snapshot.data?[index]['id'] ?? 0,
                );
                Navigator.pop(context);
                // setState(() {});
              },
              child: const Text('Oke'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
