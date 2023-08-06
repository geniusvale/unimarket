import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as providers;
import 'package:unimarket/controller/profile_provider.dart';
import 'package:unimarket/screens/profile/edit_profile.dart';

import '../../controller/cart_provider.dart';
import '../../models/cart/cart_items/cart_items_model.dart';
import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
    this.snapshotData,
    this.subtotal,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();

  final List<CartItemsModel>? snapshotData;
  final int? subtotal;
}

class _CheckoutState extends State<Checkout> {
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        providers.Provider.of<CartProvider>(context, listen: true);
    final profileProvider =
        providers.Provider.of<ProfileProvider>(context, listen: true);
    String? formattedUserAlamat =
        '${profileProvider.loggedUserData!.address?.alamat} ${profileProvider.loggedUserData!.address?.type} ${profileProvider.loggedUserData!.address?.city_name}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  child: const Text(
                    'Rincian Produk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: ListView.separated(
              itemCount: widget.snapshotData!.length,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 30,
                    height: 40,
                    child: Image.network(
                        widget.snapshotData![index].products!.img_url!),
                  ),
                  title: Text(widget.snapshotData![index].products!.name!),
                  subtitle:
                      Text(widget.snapshotData![index].products!.category!),
                  trailing: Text(
                    numberCurrency.format(
                      widget.snapshotData![index].products!.price,
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
                const Divider(height: 1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ongkos Kirim : '),
                      Text(
                        numberCurrency.format(cartProvider.currentOngkirVal),
                      ),
                    ],
                  ),
                ),
                //Jika ada barang fisik, maka hitung ongkos kirim nya! Buat fungsi IF nanti.
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Biaya Layanan : '),
                      Text(
                        numberCurrency.format(cartProvider.biayaLayanan),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jumlah : '),
                      Text('${widget.snapshotData!.length} Item'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal : ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        numberCurrency.format(
                          widget.subtotal! +
                              cartProvider.currentOngkirVal +
                              cartProvider.biayaLayanan,
                        ),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                BlueButton(
                  padding: 8,
                  teks: 'BUAT PESANAN',
                  onPressed: () async {
                    if (profileProvider.loggedUserData!.address != null &&
                        profileProvider.loggedUserData!.phone!.isNotEmpty) {
                      isLoading = true;
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            loadingIndicator,
                      );
                      await cartProvider.makeOrderAndPay(
                        context: context,
                        snapshotData: widget.snapshotData!,
                        userData: profileProvider.loggedUserData!,
                        ongkir: cartProvider.currentOngkirVal,
                        shippingInfo: cartProvider.currentShipmentService ?? '',
                        subtotal: widget.subtotal! +
                            cartProvider.currentOngkirVal +
                            cartProvider.biayaLayanan,
                      );
                      isLoading = false;
                      Navigator.of(context, rootNavigator: true).pop();
                      cartProvider.currentCourierData == null;
                      cartProvider.currentOngkirVal == 0;
                    } else {
                      return snackbar(
                        context,
                        'Harap Lengkapi Data & Nomor HP!',
                        Colors.red,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
