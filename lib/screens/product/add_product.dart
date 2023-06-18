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

  List<String> kategori = [
    'Pilih Kategori Produk',
    'Jasa',
    'Produk Digital',
    'Produk Fisik'
  ];
  String selKategori = 'Pilih Kategori Produk';

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: formPadding,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      //Bisa Dikasih Gesture Detector
                      Container(
                        height: 120,
                        width: 120,
                        color: Colors.grey,
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ),
                      formSpacer,
                      const Text('Upload Foto Produk - Max 5MB'),
                    ],
                  ),
                  formSpacer,
                  TextFormField(
                    controller: nameC,
                    decoration: formDecor(hint: 'Nama Produk'),
                  ),
                  formSpacer,
                  DropdownButtonFormField<String>(
                      decoration: formDecor(hint: ''),
                      value: selKategori,
                      items: kategori.map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selKategori = value.toString();
                        });
                      }),
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
      ),
    );
  }
}
