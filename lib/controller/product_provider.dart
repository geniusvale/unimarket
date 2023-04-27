import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utilities/constants.dart';

class ProductsProvider extends ChangeNotifier {
  void addProduct({String? name, desc, int? price}) async {
    await supabase.from('products').insert(
      {
        'name': name,
        'price': price,
        'desc': desc,
      },
    );
    notifyListeners();
    //WORKING GOOD
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    final supabase = Supabase.instance.client;
    final allProducts =
        await supabase.from('products').select<List<Map<String, dynamic>>>();
    notifyListeners();
    return allProducts;
    //WORKING GOOD
  }

  deleteProduct(int productId) async {
    await supabase.from('products').delete().match({'id': productId});
    notifyListeners();
    //WORKING GOOD
  }

  editProduct({
    String? name,
    desc,
    int? price,
    String? currentName,
    currentDesc,
    currentPrice,
  }) async {
    await supabase.from('products').update({
      'name': name,
      'price': price,
      'desc': desc,
    }).match({
      'name': currentName,
      'price': currentPrice,
      'desc': currentDesc,
    });
    notifyListeners();
    //WORKING GOOD
  }
}
