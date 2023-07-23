import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product/product_model.dart';
import '../utilities/constants.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? allProducts; //Masih Kosong, harus ada operasi add
  List<ProductModel>? allMyProducts; //Masih Kosong, harus ada operasi add
  ProductModel? productData; //Masih Kosong, harus ada operasi add

  //Tambah Produk Ke DB
  addProduct(
      {String? name,
      desc,
      category,
      userId,
      yourFileName,
      yourPhotoName,
      int? price,
      int? weight,
      File? yourFile,
      File? yourPhoto}) async {
    if (category == 'Produk Digital') {
      //BUAT DATA PRODUK KE TABLE
      await supabase.from('products').insert(
        {
          'name': name,
          'price': price,
          'weight': weight,
          'desc': desc,
          'category': category,
          'seller_id': userId
        },
      );
      //AMBIL ID PRODUK YANG BARU DIBUAT
      final recentProductId = await supabase
          .from('products')
          .select('id, created_at')
          .eq('seller_id', supabase.auth.currentUser!.id)
          .order('created_at', ascending: false)
          .limit(1)
          .single();
      print(recentProductId);
      //UPLOAD FILE
      await supabase.storage.from('product-files').upload(
          '${supabase.auth.currentUser!.id}/${recentProductId['id']}/$yourFileName',
          yourFile!);
      final fileUrl = supabase.storage
          .from(
              'product-files/${supabase.auth.currentUser!.id}/${recentProductId['id']}')
          .getPublicUrl(yourFileName);
      //UPLOAD FOTO
      await supabase.storage.from('product-images').upload(
          '${supabase.auth.currentUser!.id}/${recentProductId['id']}/$yourPhotoName',
          yourPhoto!);
      final photoUrl = supabase.storage
          .from(
              'product-images/${supabase.auth.currentUser!.id}/${recentProductId['id']}')
          .getPublicUrl(yourPhotoName);
      //UPDATE KE TABLE PRODUCT
      await supabase.from('products').update({
        'file_url': fileUrl,
        'img_url': photoUrl,
      }).eq('id', recentProductId['id']);
    } else {
      //SELAIN PRODUK DIGITAL
      await supabase.from('products').insert(
        {
          'name': name,
          'price': price,
          'weight': weight,
          'desc': desc,
          'category': category,
          'seller_id': userId
        },
      );
      //AMBIL ID PRODUK YANG BARU DIBUAT
      final recentProductId = await supabase
          .from('products')
          .select('id, created_at')
          .eq('seller_id', supabase.auth.currentUser!.id)
          .order('created_at', ascending: false)
          .limit(1)
          .single();
      //UPLOAD FOTO
      await supabase.storage.from('product-images').upload(
          '${supabase.auth.currentUser!.id}/${recentProductId['id']}/$yourPhotoName',
          yourPhoto!);
      final photoUrl = supabase.storage
          .from(
              'product-images/${supabase.auth.currentUser!.id}/${recentProductId['id']}')
          .getPublicUrl(yourPhotoName);
      //UPDATE KE TABLE PRODUCT
      await supabase.from('products').update({
        'img_url': photoUrl,
      }).eq('id', recentProductId['id']);
    }
    notifyListeners();
  }

  //Menampilkan Seluruh Produk Dari Tabel di DB
  Future<List<ProductModel>> getProduct() async {
    final supabase = Supabase.instance.client;
    final result =
        await supabase.from('products').select('*, profiles:seller_id(*)');
    final allProducts = result
        .map<ProductModel>(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
    notifyListeners();
    return allProducts;
    //WORKING GOOD
  }

  //Menampilkan Seluruh Produk Dari Toko Saya
  Future<List<ProductModel>> getMyStoreProduct() async {
    final supabase = Supabase.instance.client;
    final result = await supabase
        .from('products')
        .select('*, profiles:seller_id(*)')
        .eq('seller_id', supabase.auth.currentUser!.id);
    final semuaProdukSaya = result
        .map<ProductModel>(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
    // allMyProducts?.add(semuaProduk);
    notifyListeners();
    return semuaProdukSaya;
    //WORKING GOOD
  }

  //Hapus Produk
  deleteProduct(
      {required int productId,
      String? fileName,
      required String photoName}) async {
    await supabase.from('products').delete().match({'id': productId});
    await supabase.storage
        .from('product-files')
        .remove(['${supabase.auth.currentUser!.id}/$productId/$fileName']);
    await supabase.storage
        .from('product-images')
        .remove(['${supabase.auth.currentUser!.id}/$productId/$photoName']);
    notifyListeners();
    //WORKING GOOD
  }

  showDeleteProduct(BuildContext context,
      AsyncSnapshot<List<ProductModel>> snapshot, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      loadingIndicator,
                );
                await ProductsProvider().deleteProduct(
                  productId: snapshot.data![index].id ?? 0,
                  fileName:
                      snapshot.data![index].file_url?.split('/').last ?? '',
                  photoName: snapshot.data![index].img_url!.split('/').last,
                );
                Navigator.of(context, rootNavigator: true).pop();
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
  }

  updateProduct({
    int? productId,
    String? currentName,
    String? currentDesc,
    String? currentCategory,
    String? currentFileName,
    String? currentPhotoName,
    String? newFileName,
    String? newPhotoName,
    int? currentPrice,
    int? currentWeight,
    File? newFile,
    File? newPhoto,
  }) async {
    if (currentCategory == 'Produk Digital') {
      //BUAT DATA PRODUK KE TABLE
      await supabase.from('products').update(
        {
          'name': currentName,
          'price': currentPrice,
          'weight': currentWeight,
          'desc': currentDesc,
          'category': currentCategory,
        },
      ).eq('id', productId);

      if (newFile != null && newPhoto != null) {
        //UPDATE FILE (HAPUS YANG LAMA GANTI YANG BARU)
        await supabase.storage.from('product-files').remove([
          '${supabase.auth.currentUser!.id}/$productId/${currentFileName!.split('/').last}'
        ]);
        await supabase.storage.from('product-files').upload(
            '${supabase.auth.currentUser!.id}/$productId/$newFileName',
            newFile);
        final fileUrl = supabase.storage
            .from('product-files/${supabase.auth.currentUser!.id}/$productId')
            .getPublicUrl(newFileName!);
        //UPDATE FOTO (HAPUS YANG LAMA GANTI YANG BARU)
        await supabase.storage.from('product-images').remove([
          '${supabase.auth.currentUser!.id}/$productId/${currentPhotoName!.split('/').last}'
        ]);
        await supabase.storage.from('product-images').upload(
            '${supabase.auth.currentUser!.id}/$productId/$newPhotoName',
            newPhoto);
        final photoUrl = supabase.storage
            .from('product-images/${supabase.auth.currentUser!.id}/$productId')
            .getPublicUrl(newPhotoName!);
        //UPDATE KE TABLE PRODUCT
        await supabase.from('products').update({
          'file_url': fileUrl,
          'img_url': photoUrl,
        }).eq('id', productId);
      } else if (newFile != null) {
        //UPLOAD & UPDATE FILE NYA SAJA (HAPUS YANG LAMA GANTI YANG BARU)
        await supabase.storage.from('product-files').remove([
          '${supabase.auth.currentUser!.id}/$productId/${currentFileName!.split('/').last}'
        ]);
        await supabase.storage.from('product-files').upload(
            '${supabase.auth.currentUser!.id}/$productId/$newFileName',
            newFile);
        final fileUrl = supabase.storage
            .from('product-files/${supabase.auth.currentUser!.id}/$productId')
            .getPublicUrl(newFileName!);
        //UPDATE KE TABLE PRODUCT
        await supabase.from('products').update({
          'file_url': fileUrl,
        }).eq('id', productId);
      } else if (newPhoto != null) {
        //UPLOAD & UPDATE FOTO NYA SAJA (HAPUS YANG LAMA GANTI YANG BARU)
        await supabase.storage.from('product-images').remove([
          '${supabase.auth.currentUser!.id}/$productId/${currentPhotoName!.split('/').last}'
        ]);
        await supabase.storage.from('product-images').upload(
            '${supabase.auth.currentUser!.id}/$productId/$newPhotoName',
            newPhoto);
        final photoUrl = supabase.storage
            .from('product-images/${supabase.auth.currentUser!.id}/$productId')
            .getPublicUrl(newPhotoName!);
        //UPDATE KE TABLE PRODUCT
        await supabase.from('products').update({
          'img_url': photoUrl,
        }).eq('id', productId);
      } else {
        null;
      }
    } else {
      //SELAIN PRODUK DIGITAL
      await supabase.from('products').update(
        {
          'name': currentName,
          'price': currentPrice,
          'weight': currentWeight,
          'desc': currentDesc,
          'category': currentCategory,
        },
      ).eq('id', productId);

      if (newPhoto != null) {
        //UPLOAD & UPDATE FOTO NYA SAJA (HAPUS YANG LAMA GANTI YANG BARU)
        await supabase.storage.from('product-images').remove([
          '${supabase.auth.currentUser!.id}/$productId/${currentPhotoName!.split('/').last}'
        ]);
        await supabase.storage.from('product-images').upload(
            '${supabase.auth.currentUser!.id}/$productId/$newPhotoName',
            newPhoto);
        final photoUrl = supabase.storage
            .from('product-images/${supabase.auth.currentUser!.id}/$productId')
            .getPublicUrl(newPhotoName!);
        //UPDATE KE TABLE PRODUCT
        await supabase.from('products').update({
          'img_url': photoUrl,
        }).eq('id', productId);
      } else {
        null;
      }
    }
    notifyListeners();
  }

  addToWishlist(
      {String? usersId, int? productId, required BuildContext context}) async {
    try {
      await supabase.from('wishlist').insert({
        'users_id': usersId,
        'products_id': productId,
      });
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
