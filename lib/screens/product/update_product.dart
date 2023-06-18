import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/product_provider.dart';
import '../../models/product/product_model.dart';
import '../../utilities/constants.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({Key? key, required this.index, required this.snapshot})
      : super(key: key);
  int index;
  AsyncSnapshot<List<ProductModel>> snapshot;
  // ProductModel? snapshot;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final descC = TextEditingController();
  int randomNumber = Random().nextInt(999);
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Container(
        padding: formPadding,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Column(
              children: [
                TextFormField(
                  controller: nameC,
                  decoration: formDecor(
                    hint: widget.snapshot.data![widget.index].name ?? '',
                  ),
                ),
                formSpacer,
                TextFormField(
                  controller: priceC,
                  decoration: formDecor(
                    hint: widget.snapshot.data![widget.index].price.toString(),
                  ),
                ),
                formSpacer,
                TextFormField(
                  controller: descC,
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: null,
                  decoration: formDecor(
                    hint: widget.snapshot.data![widget.index].desc ??
                        'Tidak Ada Deskripsi',
                  ),
                ),
                formSpacer,
                ElevatedButton(
                  onPressed: () async {
                    await productProvider.editProduct(
                      name: nameC.text,
                      price: int.parse(priceC.text),
                      desc: descC.text,
                      currentName: widget.snapshot.data![widget.index].name,
                      currentPrice:
                          widget.snapshot.data![widget.index].price.toString(),
                      currentDesc: widget.snapshot.data![widget.index].desc,
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
  }
}
