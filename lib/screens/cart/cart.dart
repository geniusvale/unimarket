import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/models/cart/cart_items/cart_items_model.dart';
import 'package:unimarket/models/courier/courier_model.dart';
import 'package:unimarket/utilities/widgets.dart';

import '../../controller/cart_provider.dart';

import '../../utilities/constants.dart';
import '../profile/edit_profile.dart';
import 'checkout.dart';

class Seller {
  final String sellerId;
  int totalOngkir;

  Seller({required this.sellerId, this.totalOngkir = 0});
}

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int subtotal = 0;
  int totalGram = 0;
  int currentOngkirVal = 0;
  bool? isLoading;

  @override
  void initState() {
    // CartProvider().getMyCart();
    // getAndShowMyCart();
    super.initState();
  }

  // List<Seller> groupProductsBySellerId(List<CartItemsModel> products) {
  // Map<String, Seller> groupedSellers = {};

  // for (var product in products) {
  //   if (!groupedSellers.containsKey(product.products!.seller_id!)) {
  //     groupedSellers[product.products!.seller_id!] = Seller(sellerId: product.products!.seller_id!);
  //   }
  //   if (product.products!.category == 'Produk Fisik') {
  //     groupedSellers[product.products!.seller_id!]!.totalOngkir = 0;
  //   }
  // }

  // return groupedSellers.values.toList();
  // }

  Map<String, List<CartItemsModel>> groupProductsBySellerId(
      List<CartItemsModel> products) {
    Map<String, List<CartItemsModel>> groupedProducts = {};

    for (var product in products) {
      if (!groupedProducts.containsKey(product.products!.seller_id)) {
        groupedProducts[product.products!.seller_id!] = [];
      }
      groupedProducts[product.products!.seller_id]!.add(product);
    }
    return groupedProducts;
  }

  List<Map<String, dynamic>> listOngkir = [];

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        providers.Provider.of<CartProvider>(context, listen: false);
    final profileProvider =
        providers.Provider.of<ProfileProvider>(context, listen: false);
    String? formattedUserAlamat =
        '${profileProvider.loggedUserData!.address?.alamat} ${profileProvider.loggedUserData!.address?.type} ${profileProvider.loggedUserData!.address?.city_name}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: FutureBuilder<List<CartItemsModel>>(
        future: cartProvider.getMyCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Anda Belum Memiliki Item'),
            );
          } else {
            int newSubtotal = cartProvider.jumlahkanSubtotal(snapshot.data!);
            int newOngkir = cartProvider.currentOngkirVal;
            subtotal = newSubtotal;
            List<CartItemsModel> products = snapshot.data!;
            Map<String, List<CartItemsModel>> groupedProducts =
                groupProductsBySellerId(products);
            int newTotalGram = cartProvider.jumlahkanBeratGram(products);
            totalGram = newTotalGram;
            int currentSellerGram = newTotalGram;
            // sellers =
            //     groupProductsBySellerId(products);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                    itemCount: groupedProducts.keys.length,
                    itemBuilder: (context, index) {
                      //ISI DAN PROSES DARI TIAP SELLER
                      String sellerId = groupedProducts.keys.elementAt(index);
                      List<CartItemsModel> sellerProducts =
                          groupedProducts[sellerId]!;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //TAMPIL NAMA SELLER
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  color: Colors.grey[300],
                                  height: 35,
                                  child: Text(
                                    // 'Seller : $sellerName',
                                    'Seller : ${sellerProducts[0].products!.profiles!.username}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //ITEM DARI MASING-MASING SELLER
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sellerProducts.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, subIndex) {
                              CartItemsModel product = sellerProducts[subIndex];
                              print('TOTAL GRAM $totalGram');
                              print(
                                'TOTAL GRAM Current Seller $currentSellerGram',
                              );
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 1,
                                      onPressed: (context) async {
                                        await cartProvider.deleteCartItems(
                                          product.id!,
                                        );
                                        setState(() {});
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_outline,
                                      label: 'Hapus',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 30,
                                    height: 40,
                                    child: Image.network(
                                        product.products!.img_url!),
                                  ),
                                  title: Text(product.products!.name!),
                                  subtitle: Text(
                                    product.products!.category!,
                                  ),
                                  trailing: Text(
                                    numberCurrency
                                        .format(product.products!.price!),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                //BUTTON OR ANYTHING FOR CEK ONGKIR
                Visibility(
                  visible: products.any((element) =>
                          element.products!.category == 'Produk Fisik')
                      ? true
                      : false,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownSearch<CourierModel>(
                          popupProps: const PopupProps.dialog(
                            dialogProps: DialogProps(),
                          ),
                          items: const [
                            CourierModel(
                                code: 'jne',
                                name: 'Jalur Nugraha Ekakurir (JNE)'),
                            CourierModel(
                                code: 'tiki', name: 'Titipan Kilat (TIKI)'),
                            CourierModel(
                                code: 'pos',
                                name: 'PT Pos Indonesia (Persero)'),
                          ],
                          onChanged: (value) {
                            print('onChanged $value');
                            cartProvider.currentCourierData = CourierModel(
                              code: value!.code,
                              name: value.name,
                            );
                          },
                          selectedItem: cartProvider.currentCourierData,
                          itemAsString: (item) => '${item.name}',
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(hintText: 'Pilih kurir...'),
                          ),
                        ),
                        formSpacer,
                        providers.Consumer<CartProvider>(
                          builder: (context, value, child) => Text(
                            'Ongkir : ${value.currentOngkirVal}',
                          ),
                        )
                      ],
                    ),
                    trailing: TextButton(
                      child: const Text('Cek Ongkir'),
                      onPressed: () async {
                        if (cartProvider.currentCourierData!.code != '' ||
                            cartProvider.currentCourierData!.code != '' &&
                                profileProvider.loggedUserData!.address ==
                                    null) {
                          isLoading = true;
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    loadingIndicator,
                          );
                          await cartProvider.hitungOngkir(
                            context: context,
                            //ID Kota Cirebon, Alamat dari UCIC sebagai Origin.
                            originId: '109',
                            //ID Kota, Alamat Pembeli
                            destinationId: profileProvider
                                .loggedUserData!.address!.city_id,
                            gram: currentSellerGram.toString(),
                            kurir: cartProvider.currentCourierData!.code,
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        } else {
                          snackbar(
                            context,
                            'Harap Pilih Kurir!',
                            Colors.red,
                          );
                          null;
                        }
                      },
                    ),
                  ),
                ),
                //BAGIAN BAWAH
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(height: 1),
                      ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        ),
                        title: const Text('Alamat Pengiriman'),
                        subtitle: Text(
                          profileProvider.loggedUserData!.address == null
                              ? 'Lengkapi Data'
                              : formattedUserAlamat,
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal : ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            providers.Consumer<CartProvider>(
                              builder: (context, value, child) {
                                return Text(
                                  numberCurrency.format(
                                    subtotal + value.currentOngkirVal,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      //Button BAYAR BAYAR
                      BlueButton(
                        teks: 'CHECKOUT',
                        padding: 8,
                        onPressed: () async {
                          if (products.any((element) =>
                                      element.products!.category ==
                                      'Produk Fisik') &&
                                  cartProvider.currentOngkirVal == 0 ||
                              profileProvider.loggedUserData!.address == null) {
                            return snackbar(
                              context,
                              'Cek Ongkir / Isi Alamat Terlebih Dahulu!',
                              Colors.red,
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Checkout(
                                  snapshotData: snapshot.data!,
                                  subtotal: subtotal + currentOngkirVal,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
