// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../product/product_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'cart_items_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'cart_items_model.g.dart';

@freezed
class CartItemsModel with _$CartItemsModel {
  const factory CartItemsModel({
    required int id,
    int? cart_id,
    int? product_id,
    ProductModel? products,
    int? quantity,
  }) = _CartItemsModel;

  factory CartItemsModel.fromJson(Map<String, Object?> json) =>
      _$CartItemsModelFromJson(json);
}
