import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/controller/wishlist_provider.dart';
import 'package:unimarket/models/product/product_model.dart';

import '../controller/auth_provider.dart';
import '../controller/store_provider.dart';
import '../utilities/constants.dart';
import 'product/detail_product.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  int randomNumber = Random().nextInt(999);
  @override
  Widget build(BuildContext context) {
    final storeProvider =
        providers.Provider.of<StoreProvider>(context, listen: false);
    final authProvider = providers.Provider.of<AuthProvider>(context);
    final wishlistProvider =
        providers.Provider.of<WishlistProvider>(context, listen: false);
    return Scaffold(
      //Kasih Blocked Action Jika Unauthenticated
      body: authProvider.unAuthorized
          ? const Center(
              child: Text('Wishlist Kosong'),
            )
          : Padding(
              padding: formPadding,
              child: FutureBuilder<List<ProductModel>>(
                future: wishlistProvider.getWishlist(),
                builder: (context, snapshot) {
                  print('status unAuthorized ${authProvider.unAuthorized}');
                  if (snapshot.connectionState == ConnectionState.done &&
                      authProvider.unAuthorized == false) {
                    return MasonryGridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data?.length ?? 0,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0.3,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailProduct(
                                      index: index,
                                      snapshot: snapshot,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://picsum.photos/id/${index + randomNumber}/200/200',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) {
                                          return CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return const Icon(
                                            Icons.broken_image_outlined,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                formSpacer,
                                Padding(
                                  padding: formPadding,
                                  child: Text(
                                    snapshot.data?[index].name ?? '~Error',
                                    // '',
                                  ),
                                ),
                                Padding(
                                  padding: formPadding,
                                  child: Text(
                                    'Rp ${snapshot.data![index].price}',
                                    // '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                formSpacer
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return loadingIndicator;
                  }
                },
              ),
            ),
    );
  }
}
