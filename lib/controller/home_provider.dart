import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'product_provider.dart';

class HomeProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  int currentIndex = 0;
  PageController pageController = PageController();

  changePage(int value) {
    currentIndex = value;
    notifyListeners();
  }

  void showAddProduct(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
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
                  ElevatedButton(
                    onPressed: () async {
                      ProductsProvider().addProduct(
                        nameC.text,
                        int.parse(priceC.text),
                      );
                      nameC.clear();
                      priceC.clear();
                      // setState(() {
                      //   nameC.clear();
                      //   priceC.clear();
                      // });
                      Navigator.pop(context);
                    },
                    child: const Text('ADD PRODUCT'),
                  ),
                ],
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
      context: context,
      builder: (context) {
        return Container(
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
                  ElevatedButton(
                    onPressed: () async {
                      await ProductsProvider().editProduct(
                        nameC.text,
                        int.parse(priceC.text),
                        snapshot.data![index]['name'],
                        snapshot.data![index]['price'].toString(),
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
