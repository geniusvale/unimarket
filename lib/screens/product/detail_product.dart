import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_provider.dart';
import '../../controller/product_provider.dart';
import '../../models/product/product_model.dart';
import '../../utilities/constants.dart';
import '../auth/login.dart';

class DetailProduct extends StatefulWidget {
  DetailProduct({Key? key, required this.index, required this.snapshot})
      : super(key: key);
  int index;
  AsyncSnapshot<List<ProductModel>> snapshot;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int randomNumber = Random().nextInt(999);
  int tabIndex = 0;
  bool isNull = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    print(widget.snapshot);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                imageUrl:
                    'https://picsum.photos/id/${widget.index + randomNumber}/200/200',
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
              widget.snapshot.data![widget.index].name ?? 'Tak Ada Data',
              style: const TextStyle(fontSize: 24),
            ),
            formSpacer,
            Text(
              'Rp ' + widget.snapshot.data![widget.index].price.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            formSpacer,
            const Text(
              'Informasi Produk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.snapshot.data![widget.index].desc ?? 'No Deskripsi',
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      try {
                        if (authProvider.unAuthorized == false) {
                          final user = supabase.auth.currentUser;
                          productProvider.addToWishlist(
                            usersId: user!.id,
                            productId: widget.snapshot.data![widget.index].id,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      color: Colors.grey[800],
                    ),
                    label: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
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
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (authProvider.unAuthorized == true) {
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
                      child: const Text('Tambah Ke Keranjang'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
