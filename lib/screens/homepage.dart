import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/controller/home_provider.dart';
import 'package:unimarket/controller/product_provider.dart';
import 'package:unimarket/utilities/constants.dart';
import 'package:provider/provider.dart' as providers;

import 'cart.dart';
import 'profile.dart';
import 'wishlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _currentIndex = 0;
  // PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final homeProvider = providers.Provider.of<HomeProvider>(context);
    print('Index sekarang ${homeProvider.currentIndex}');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('UniMarket.', style: TextStyle(fontSize: 24)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      // appBarz,
      body: PageView(
        controller: homeProvider.pageController,
        onPageChanged: (value) {
          homeProvider.changePage(value);
        },
        children: const [
          Home(),
          Wishlist(),
          Cart(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        currentIndex: homeProvider.currentIndex,
        onTap: (value) {
          homeProvider.changePage(value);
          homeProvider.pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 3),
            curve: Curves.ease,
          );
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
                'assets/icons/shopping-bag.svg',
                width: 20,
                height: 20,
              ),
              label: 'Orders'),
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
  final supabase = Supabase.instance.client;
  int randomNumber = Random().nextInt(999);
  int randomNumberHeight = Random().nextInt(100);
  @override
  Widget build(BuildContext context) {
    final homeProvider =
        providers.Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          homeProvider.showAddProduct(context);
        },
        child: const Icon(Icons.add),
      ),
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
                'Explore our\ncreation.',
                textAlign: TextAlign.start,
                style: titleText,
              ),
              formSpacer,
              FutureBuilder<List<Map<String, dynamic>>>(
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
                              print(randomNumberHeight);
                              print(index);
                              homeProvider.showUpdateProduct(
                                context,
                                snapshot,
                                index,
                              );
                            },
                            onLongPress: () {
                              homeProvider.showDeleteProduct(
                                context,
                                snapshot,
                                index,
                              );
                              setState(() {});
                            },
                            onDoubleTap: () {
                              homeProvider.showDetailProduct(
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
                                      child: Image.network(
                                        'https://picsum.photos/id/${index + randomNumber}/200/200',
                                        fit: BoxFit.fill,
                                        width: 200,
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
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
