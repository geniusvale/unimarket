import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unimarket/controller/product_provider.dart';
import 'package:unimarket/utilities/constants.dart';

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
    print(_currentIndex);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('UniMarket', style: TextStyle(fontSize: 24)),
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
        // type: BottomNavigationBarType.fixed,
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
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameC,
                            decoration: const InputDecoration(
                              hintText: 'Nama Produk',
                            ),
                          ),
                          formSpacer,
                          TextFormField(
                            controller: priceC,
                            decoration:
                                const InputDecoration(hintText: 'Harga'),
                          ),
                          formSpacer,
                          ElevatedButton(
                            onPressed: () async {
                              ProductProvider().addProduct(
                                nameC.text,
                                int.parse(priceC.text),
                              );
                              setState(() {
                                nameC.clear();
                                priceC.clear();
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('ADD PRODUCT'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add)),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ProductProvider().getProduct(),
        builder: (context, snapshot) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisExtent: 200,
            ),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Hapus?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              ProductProvider().deleteProduct(
                                snapshot.data?[index]['id'] ?? 0,
                              );
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text('Oke'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Batal'),
                          ),
                        ],
                      );
                    },
                  );
                },
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameC,
                                  decoration: InputDecoration(
                                    hintText: snapshot.data![index]['name'],
                                  ),
                                  // initialValue: snapshot.data![index]['name'],
                                ),
                                formSpacer,
                                TextFormField(
                                  controller: priceC,
                                  decoration: InputDecoration(
                                    hintText: snapshot.data![index]['price']
                                        .toString(),
                                  ),
                                  // initialValue:
                                  //     snapshot.data![index]['price'].toString(),
                                  // decoration: InputDecoration(
                                  //     hintText: snapshot.data?[index]['price']
                                  //         .toString()),
                                ),
                                formSpacer,
                                ElevatedButton(
                                  onPressed: () async {
                                    await ProductProvider().editProduct(
                                      nameC.text,
                                      int.parse(priceC.text),
                                      snapshot.data![index]['name'],
                                      snapshot.data![index]['price'].toString(),
                                    );
                                    Navigator.pop(context);
                                    setState(() {
                                      nameC.clear();
                                      priceC.clear();
                                    });
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  // height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: Colors.grey),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: Image.network(
                          'https://picsum.photos/200/300',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          snapshot.data?[index]['name'] ?? '~Error',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Rp ${snapshot.data![index]['price']}'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
