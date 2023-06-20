import 'package:dotted_border/dotted_border.dart';
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
        title: const Text('Update Product'),
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
                      DottedBorder(
                        strokeWidth: 2,
                        dashPattern: const [6, 3, 6, 3],
                        child: Container(
                          height: 120,
                          width: 120,
                          color: Colors.grey,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt_outlined),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      formSpacer,
                      const Text('Upload Foto Produk - Max 5MB'),
                    ],
                  ),
                  formSpacer,
                  TextFormField(
                    controller: nameC,
                    decoration: formDecor(
                      hint: widget.snapshot.data![widget.index].name ?? '',
                    ),
                  ),
                  formSpacer,
                  DropdownButtonFormField<String>(
                      decoration: formDecor(hint: ''),
                      value: widget.snapshot.data![widget.index].category,
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
                    decoration: formDecor(
                      hint:
                          widget.snapshot.data![widget.index].price.toString(),
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
                  //BUTTON
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await productProvider.editProduct(
                              name: nameC.text,
                              price: int.parse(priceC.text),
                              desc: descC.text,
                              currentName:
                                  widget.snapshot.data![widget.index].name,
                              currentPrice: widget
                                  .snapshot.data![widget.index].price
                                  .toString(),
                              currentDesc:
                                  widget.snapshot.data![widget.index].desc,
                            );
                            nameC.clear();
                            priceC.clear();
                            descC.clear();
                            Navigator.pop(context);
                          },
                          child: const Text('Update'),
                        ),
                      ),
                    ],
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
