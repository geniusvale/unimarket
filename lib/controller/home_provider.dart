import 'dart:math';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'product_provider.dart';

class HomeProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final descC = TextEditingController();
  int currentIndex = 0;
  PageController pageController = PageController();
  int randomNumber = Random().nextInt(999);

  changePage(int value) {
    currentIndex = value;
    notifyListeners();
  }

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
                  child: Image.network(
                    'https://picsum.photos/id/${index + randomNumber}/200/200',
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
                          onPressed: () async {},
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
                        Navigator.pop(context);
                        // setState(() {
                        //   nameC.clear();
                        //   priceC.clear();
                        // });
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
