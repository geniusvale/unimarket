import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/controller/home_provider.dart';
import 'package:unimarket/controller/product_provider.dart';
import 'package:unimarket/controller/seller_request_provider.dart';
import 'package:unimarket/controller/wishlist_provider.dart';
import 'package:unimarket/models/product/product_model.dart';
import 'package:unimarket/screens/product/detail_product.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:provider/provider.dart' as providers;

import '../controller/auth_provider.dart';
import '../controller/profile_provider.dart';
import '../controller/store_provider.dart';
import 'cart.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = providers.Provider.of<HomeProvider>(context);
    final profileProvider = providers.Provider.of<ProfileProvider>(context);
    final authProvider =
        providers.Provider.of<AuthProvider>(context, listen: false);
    final wishlistProvider =
        providers.Provider.of<WishlistProvider>(context, listen: false);
    final productsProvider =
        providers.Provider.of<ProductsProvider>(context, listen: false);
    final sellerRequestProvider =
        providers.Provider.of<SellerRequestProvider>(context, listen: false);
    print('Status unAuthorized ${authProvider.unAuthorized.toString()}');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('UniMarket.', style: TextStyle(fontSize: 24)),
        leading: IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          icon: const Icon(Icons.search_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // profileProvider.getProfileDataFromAuth(context);
              // wishlistProvider.getWishlist();
              // productsProvider.getProduct();
              sellerRequestProvider.getSellerRequestList();
            },
            icon: SvgPicture.asset(
              'assets/icons/bell.svg',
              width: 20,
              height: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
      // appBarz,
      body: homeProvider.pages[homeProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        currentIndex: homeProvider.currentIndex,
        onTap: (value) {
          homeProvider.changePage(value);
        },
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 20,
                height: 20,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 20,
                height: 20,
              ),
              label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/receipt.svg',
                width: 20,
                height: 20,
              ),
              label: 'Transactions'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              width: 20,
              height: 20,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int randomNumber = Random().nextInt(999);
  int randomNumberHeight = Random().nextInt(100);
  @override
  Widget build(BuildContext context) {
    final storeProvider =
        providers.Provider.of<StoreProvider>(context, listen: false);
    final productsProvider =
        providers.Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            return;
          });
        },
        child: Padding(
          padding: formPadding,
          child: ListView(
            children: [
              const Text(
                'Jelajahi \nkarya kami.',
                textAlign: TextAlign.start,
                style: titleText,
              ),
              formSpacer,
              FutureBuilder<List<ProductModel>>(
                future: productsProvider.getProduct(),
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
                              // storeProvider.showDetailProduct(
                              //   context,
                              //   snapshot,
                              //   index,
                              // );
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
                                  ),
                                ),
                                Padding(
                                  padding: formPadding,
                                  child: Text(
                                    'Rp ${snapshot.data![index].price}',
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
            ],
          ),
        ),
      ),
    );
  }
}
