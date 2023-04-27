import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart' as providers;
import 'package:cached_network_image/cached_network_image.dart';

import '../../controller/home_provider.dart';
import '../../controller/product_provider.dart';
import '../../controller/store_provider.dart';
import '../../utilities/constants.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({Key? key}) : super(key: key);

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  // final supabase = Supabase.instance.client;
  int randomNumber = Random().nextInt(999);
  int randomNumberHeight = Random().nextInt(100);
  @override
  Widget build(BuildContext context) {
    final storeProvider =
        providers.Provider.of<StoreProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          storeProvider.showAddProduct(context);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            return;
          });
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ProductsProvider().getProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MasonryGridView.builder(
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
                        storeProvider.showDetailProduct(
                          context,
                          snapshot,
                          index,
                        );
                      },
                      onLongPress: () {
                        storeProvider.showDeleteProduct(
                          context,
                          snapshot,
                          index,
                        );
                      },
                      onDoubleTap: () {
                        print(randomNumberHeight);
                        print(index);
                        storeProvider.showUpdateProduct(
                          context,
                          snapshot,
                          index,
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
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      'https://picsum.photos/id/${index + randomNumber}/200/200',
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
                            ),
                          ),
                          formSpacer,
                          Padding(
                            padding: formPadding,
                            child: Text(
                              snapshot.data?[index]['name'] ?? '~Error',
                            ),
                          ),
                          Padding(
                            padding: formPadding,
                            child: Text(
                              'Rp ${snapshot.data![index]['price']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
