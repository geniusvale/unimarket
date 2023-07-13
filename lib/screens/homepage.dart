import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimarket/controller/cart_provider.dart';
import 'package:unimarket/controller/home_provider.dart';
import 'package:unimarket/controller/product_provider.dart';
import 'package:unimarket/controller/seller_request_provider.dart';
import 'package:unimarket/controller/transaction_provider.dart';
import 'package:unimarket/controller/wishlist_provider.dart';
import 'package:unimarket/models/product/product_model.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:provider/provider.dart' as providers;

import '../controller/auth_provider.dart';
import '../controller/profile_provider.dart';
import '../controller/store_provider.dart';
import '../utilities/widgets.dart';
import 'cart/cart.dart';
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
    final cartProvider =
        providers.Provider.of<CartProvider>(context, listen: false);
    final transactionProvider =
        providers.Provider.of<TransactionProvider>(context, listen: false);
    final storeProvider =
        providers.Provider.of<StoreProvider>(context, listen: false);
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
            onPressed: () async {
              // storeProvider.getMyOrderJson();
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
  void initState() {
    super.initState();
  }

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
                        return ProductCard(index: index, snapshot: snapshot);
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
