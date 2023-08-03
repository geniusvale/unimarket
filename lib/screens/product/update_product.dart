import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../controller/product_provider.dart';
import '../../models/product/product_model.dart';
import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({Key? key, required this.index, required this.snapshot})
      : super(key: key);
  int index;
  AsyncSnapshot<List<ProductModel>> snapshot;
  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController weightC = TextEditingController();
  File? pickedPhoto;
  String? pickedPhotoName;
  File? pickedFile;
  String? pickedFileName;

  String? currentFileUrl;
  String? currentPhotoUrl;

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
    nameC.text = widget.snapshot.data![widget.index].name!;
    priceC.text = widget.snapshot.data![widget.index].price!.toString();
    weightC.text =
        widget.snapshot.data![widget.index].weight?.toString() ?? '0';
    descC.text = widget.snapshot.data![widget.index].desc!;
    selKategori = widget.snapshot.data![widget.index].category!;
    currentPhotoUrl = widget.snapshot.data![widget.index].img_url!;
    if (selKategori == 'Produk Digital') {
      currentFileUrl = widget.snapshot.data![widget.index].file_url!;
    } else {
      null;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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
                              ? GestureDetector(
                                  onTap: () async {
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
                                  child: Image.file(pickedPhoto!,
                                      fit: BoxFit.fill),
                                )
                              : pickedPhoto == null
                                  ? GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.image);
                                        if (result != null) {
                                          pickedPhoto = File(
                                            result.files.first.path!,
                                          );
                                          pickedPhotoName = result
                                              .files.first.name
                                              .replaceAll(' ', '');
                                          setState(() {});
                                        } else {
                                          //Cancel
                                        }
                                      },
                                      child: CachedNetworkImage(
                                          imageUrl: currentPhotoUrl!,
                                          fit: BoxFit.fill),
                                    )
                                  : IconButton(
                                      icon:
                                          const Icon(Icons.camera_alt_outlined),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.image);
                                        if (result != null) {
                                          pickedPhoto = File(
                                            result.files.first.path!,
                                          );
                                          pickedPhotoName =
                                              result.files.first.name;
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
                    onChanged: null,
                    // (value) {
                    //   setState(() {
                    //     selKategori = value.toString();
                    //   });
                    // },
                  );
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
                        pickedFile != null
                            ? Expanded(child: Text('File Anda : $pickedFile'))
                            : Expanded(
                                child: Text(
                                  'File Anda : ${currentFileUrl!.split('/').last}',
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
                              pickedFileName = result.files.first.name;
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
                validator: (value) => hargaValidator(value!),
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
                teks: 'Update Product',
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      isLoading = true;
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Container(
                          child: loadingIndicator,
                        ),
                      );
                      print(pickedPhotoName);
                      print(pickedPhoto);
                      print(pickedFileName);
                      print(pickedFile);
                      await productProvider.updateProduct(
                        productId: widget.snapshot.data![widget.index].id,
                        currentName: nameC.text,
                        currentDesc: descC.text,
                        currentPrice: int.parse(priceC.text),
                        currentWeight: int.tryParse(weightC.text),
                        currentCategory: selKategori,
                        newFile: pickedFile,
                        newFileName: pickedFileName,
                        currentFileName:
                            widget.snapshot.data![widget.index].file_url,
                        newPhoto: pickedPhoto,
                        newPhotoName: pickedPhotoName,
                        currentPhotoName:
                            widget.snapshot.data![widget.index].img_url,
                      );
                      nameC.clear();
                      priceC.clear();
                      descC.clear();
                      isLoading = false;
                      DefaultCacheManager manager = DefaultCacheManager();
                      manager.emptyCache();
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pop(context);
                      snackbar(
                          context, 'Sukses Mengupdate Produk', Colors.green);
                    } else {
                      return snackbar(
                          context, 'Error Mengupdate!', Colors.black);
                    }
                  } catch (e) {
                    Navigator.pop(context);
                    snackbar(context, e.toString(), Colors.black);
                    rethrow;
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
