import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/product_provider.dart';
import '../../utilities/constants.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final descC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
        padding: formPadding,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Column(
              children: [
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
                    productProvider.addProduct(
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
  }
}
