import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utilities/constants.dart';

class ProductProvider extends ChangeNotifier {
  void addProduct(String name, int price) async {
    await supabase.from('product').insert(
      {
        'name': name,
        'price': price,
      },
    );
    notifyListeners();
    //WORKING GOOD, Not Tested With Form
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    final supabase = Supabase.instance.client;
    final allProduct =
        await supabase.from('product').select<List<Map<String, dynamic>>>();
    notifyListeners();
    return allProduct;
    //WORKING GOOD
  }

  deleteProduct(int productId) async {
    await supabase.from('product').delete().match({'id': productId});
    notifyListeners();
    //WORKING GOOD
  }

  editProduct(
      String name, int price, String currentName, String currentPrice) async {
    await supabase.from('product').update({
      'name': name,
      'price': price,
    }).match({
      'name': currentName,
      'price': currentPrice,
    });
    notifyListeners();
    //WORKING GOOD
  }
}
