import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/utilities/widgets.dart';

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
  TextEditingController? weightC = TextEditingController();
  File? pickedPhoto;
  String? pickedPhotoName;
  File? pickedFile;
  String? pickedFileName;

  bool? isLoading;

  List<String> kategori = [
    'Pilih Kategori Produk',
    'Jasa',
    'Produk Digital',
    'Produk Fisik'
  ];
  String selKategori = 'Pilih Kategori Produk';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              FormField(
                builder: (field) {
                  return Row(
                    children: [
                      //Bisa Dikasih Gesture Detector
                      DottedBorder(
                        strokeWidth: 2,
                        dashPattern: const [6, 3, 6, 3],
                        child: Container(
                          height: 120,
                          width: 120,
                          color: Colors.grey,
                          child: pickedPhoto != null
                              ? Image.file(pickedPhoto!, fit: BoxFit.fill)
                              : IconButton(
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  onPressed: () async {
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(type: FileType.image);
                                    if (result != null) {
                                      pickedPhoto = File(
                                        result.files.first.path!,
                                      );
                                      pickedPhotoName = result.files.first.name
                                          .replaceAll(' ', '');
                                      setState(() {});
                                    } else {
                                      //Cancel
                                    }
                                  },
                                ),
                        ),
                      ),
                      formSpacer,
                      const Text('Upload Foto Produk - Max 5MB'),
                    ],
                  );
                },
                validator: (value) {
                  return null;
                },
              ),
              formSpacer,
              TextFormField(
                controller: nameC,
                decoration: formDecor(hint: 'Nama Produk'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Produk Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              formSpacer,
              FormField(
                builder: (field) {
                  return DropdownButtonFormField<String>(
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
                      });
                },
              ),
              formSpacer,
              Visibility(
                visible: selKategori == 'Produk Digital' ? true : false,
                child: FormField(
                  builder: (field) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pickedFile == null
                            ? const Text('File Anda : -')
                            : Expanded(
                                child: Text(
                                  'File Anda : ${pickedFile!.path}',
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                        TextButton(
                          child: const Text('Pilih File'),
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(withData: true);
                            if (result != null) {
                              pickedFile = File(result.files.first.path!);
                              pickedFileName =
                                  result.files.first.name.replaceAll(' ', '');
                              setState(() {});
                            } else {}
                          },
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: priceC,
                keyboardType: TextInputType.number,
                decoration: formDecor(hint: 'Harga'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              formSpacer,
              Visibility(
                visible: selKategori == 'Produk Fisik' ? true : false,
                child: TextFormField(
                  controller: weightC,
                  keyboardType: TextInputType.number,
                  decoration: formDecor(hint: 'Berat dalam Gram (gr)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Berat Tidak Boleh Kosong!';
                    }
                    return null;
                  },
                ),
              ),
              formSpacer,
              TextFormField(
                controller: descC,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                decoration: formDecor(hint: 'Deskripsi'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Deskripsi Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              formSpacer,
              BlueButton(
                padding: 0,
                teks: 'Add Product',
                onPressed: () async {
                  try {
                    switch (selKategori) {
                      case 'Produk Digital':
                        if (_formKey.currentState!.validate() &&
                            pickedFile != null &&
                            pickedPhoto != null) {
                          isLoading = true;
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Container(
                              child: loadingIndicator,
                            ),
                          );
                          print(pickedPhotoName);
                          print(pickedPhoto);
                          print(pickedFileName);
                          print(pickedFile);
                          await productProvider.addProduct(
                            name: nameC.text,
                            desc: descC.text,
                            price: int.parse(priceC.text),
                            category: selKategori,
                            userId: supabase.auth.currentUser!.id,
                            yourFile: pickedFile,
                            yourFileName: pickedFileName,
                            yourPhoto: pickedPhoto,
                            yourPhotoName: pickedPhotoName,
                          );
                          nameC.clear();
                          priceC.clear();
                          descC.clear();
                          isLoading = false;
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pop(context);
                          setState(() {});
                          snackbar(
                              context, 'Sukses Menambah Produk', Colors.green);
                        } else {
                          return snackbar(context, 'File & Foto Harus Dipilih!',
                              Colors.black);
                        }
                        break;
                      default:
                        if (_formKey.currentState!.validate() &&
                            pickedPhoto != null) {
                          isLoading = true;
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Container(
                              child: loadingIndicator,
                            ),
                          );
                          await productProvider.addProduct(
                            name: nameC.text,
                            desc: descC.text,
                            price: int.parse(priceC.text),
                            weight: int.tryParse(weightC!.text) ?? 0,
                            category: selKategori,
                            userId: supabase.auth.currentUser!.id,
                            yourPhoto: pickedPhoto,
                            yourPhotoName: pickedPhotoName,
                          );
                          nameC.clear();
                          priceC.clear();
                          descC.clear();
                          weightC?.clear();
                          isLoading = false;
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pop(context);
                          setState(() {});
                          snackbar(
                              context, 'Sukses Menambah Produk', Colors.green);
                        } else {
                          return snackbar(
                              context, 'Harap Isi Semua Data!', Colors.black);
                        }
                    }
                  } catch (e) {
                    final recentProductId = await supabase
                        .from('products')
                        .select('id, created_at')
                        .eq('seller_id', supabase.auth.currentUser!.id)
                        .order('created_at', ascending: false)
                        .limit(1)
                        .single();
                    await supabase
                        .from('products')
                        .delete()
                        .eq('id', recentProductId['id']);
                    Navigator.pop(context);
                    snackbar(context, e.toString(), Colors.black);
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
