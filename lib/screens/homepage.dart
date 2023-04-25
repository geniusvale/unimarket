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
  int _currentIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    print('Index sekarang $_currentIndex');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('UniMarket.', style: TextStyle(fontSize: 24)),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        children: const [
          Home(),
          Wishlist(),
          Cart(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          controller.animateToPage(
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
              label: 'Cart'),
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
                  return MasonryGridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data!.length,
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
                          child: Column(
                            children: [
                              SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://picsum.photos/id/${index + randomNumber}/200/200',
                                    fit: BoxFit.fill,
                                    width: 200,
                                  ),
                                ),
                              ),
                              formSpacer,
                              Text(
                                snapshot.data?[index]['name'] ?? '~Error',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Rp ${snapshot.data![index]['price']}'),
                              formSpacer
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
