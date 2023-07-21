import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/controller/cart_provider.dart';
import 'package:unimarket/controller/wishlist_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/auth_provider.dart';
import '../../controller/product_provider.dart';
import '../../models/product/product_model.dart';
import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';
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
  bool isOwnProduct = false;
  bool showWidget = true;

  @override
  void initState() {
    checkIfOwnProduct();
    super.initState();
  }

  Future<bool> checkIfOwnProduct() async {
    final AsyncSnapshot<List<ProductModel>> snap = widget.snapshot;
    final productSellerId = snap.data![widget.index].seller_id;
    final sellerId = supabase.auth.currentUser!.id;

    if (productSellerId == sellerId) {
      return isOwnProduct = true;
    } else {
      return isOwnProduct = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl:
                          '${widget.snapshot.data![widget.index].img_url}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  formSpacer,
                  Text(
                    numberCurrency.format(
                      widget.snapshot.data![widget.index].price,
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  formSpacer,
                  ActionChip(
                    label:
                        Text('${widget.snapshot.data![widget.index].category}'),
                    labelStyle: const TextStyle(color: Colors.black),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  formSpacer,
                  const Text(
                    'Informasi Penjual',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          height: 16,
                          width: 16,
                          child: widget.snapshot.data![widget.index].profiles!
                                      .avatar_url ==
                                  null
                              ? SvgPicture.asset('assets/images/blankpp.svg')
                              : Image.network(widget.snapshot
                                  .data![widget.index].profiles!.avatar_url!),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.snapshot.data![widget.index].profiles!.username!,
                      ),
                    ],
                  ),
                  // formSpacer,
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () async {
                      try {
                        await launchUrlString(
                          'whatsapp://send?phone=${widget.snapshot.data![widget.index].profiles!.phone!}&text=${Uri.parse('message')}',
                          // 'https://api.whatsapp.com/send?phone=62${widget.snapshot.data![widget.index].profiles!.phone!.replaceAll('0', '')}',
                          mode: LaunchMode.externalApplication,
                        );
                      } catch (e) {
                        snackbar(context, e.toString(), Colors.black);
                      }
                    },
                    icon: Image.asset(
                      'assets/icons/whatsapp.png',
                      width: 15,
                      height: 15,
                    ),
                    label: const Text('Hubungi Penjual'),
                  ),
                  formSpacer,
                  const Text(
                    'Informasi Produk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.snapshot.data![widget.index].desc ?? 'No Deskripsi',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  //Tombol Wishlist
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 2, color: Colors.grey),
                    ),
                    onPressed: () async {
                      try {
                        if (authProvider.unAuthorized == true) {
                          showWidget;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        } else if (isOwnProduct) {
                          return showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Text(
                                  'Tidak Bisa Simpan Produk Sendiri Ke Wishlist!',
                                  textAlign: TextAlign.center),
                            ),
                          );
                        } else {
                          final isAlreadyWishlished = await wishlistProvider
                              .checkIfHasSameWishlistItems(
                            productId: widget.snapshot.data![widget.index].id!,
                          );
                          if (isAlreadyWishlished == true) {
                            snackbar(
                                context, 'Produk Sudah Tersimpan!', Colors.red);
                          } else {
                            await productProvider.addToWishlist(
                              context: context,
                              usersId: supabase.auth.currentUser!.id,
                              productId: widget.snapshot.data![widget.index].id,
                            );
                            snackbar(
                                context, 'Berhasil Menyimpan!', Colors.green);
                          }
                        }
                      } catch (e) {
                        snackbar(context, e.toString(), Colors.black);
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      color: Colors.grey[800],
                      height: 15,
                    ),
                    label: Text(
                      'Simpan',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                formSpacer,
                Expanded(
                  flex: 2,
                  //Tombol Tambah Ke Keranjang
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
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
                      } else if (isOwnProduct) {
                        return showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            content: Text(
                              'Tidak Bisa Menambah Produk Anda Sendiri Ke Keranjang!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        await cartProvider.checkIfHasCart(context);
                        final isSameProduct =
                            await cartProvider.checkIfHasSameCartItems(
                          productId: widget.snapshot.data![widget.index].id!,
                          sellerId:
                              widget.snapshot.data![widget.index].seller_id!,
                          productCategory:
                              widget.snapshot.data![widget.index].category,
                          context: context,
                        );
                        print('isSameProduct $isSameProduct');
                        if (isSameProduct == true) {
                          snackbar(
                            context,
                            'Sudah Ada di Keranjang!',
                            Colors.black,
                          );
                        } else if (isSameProduct == false &&
                            widget.snapshot.data![widget.index].category ==
                                'Produk Fisik') {
                          final checkDifferentProdukFisikSeller =
                              await cartProvider.checkAlreadyProdukFisikInCart(
                            cartId: cartProvider.currentCartId,
                            productCategory:
                                widget.snapshot.data![widget.index].category,
                            sellerId:
                                widget.snapshot.data![widget.index].seller_id,
                          );
                          if (checkDifferentProdukFisikSeller == true) {
                            snackbar(
                              context,
                              'Hanya bisa menambah produk fisik dari seller yang sama yang sudah ada di keranjang!',
                              Colors.black,
                            );
                          }
                        } else {
                          try {
                            await cartProvider.addToCart(
                              productId:
                                  widget.snapshot.data![widget.index].id ?? 0,
                              usersId: supabase.auth.currentUser!.id,
                            );
                            snackbar(context, 'Berhasil Menambah ke Keranjang!',
                                Colors.black);
                          } catch (e) {
                            rethrow;
                          }
                        }
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
    );
  }
}
