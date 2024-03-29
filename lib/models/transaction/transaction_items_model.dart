// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

import '../product/product_model.dart';
import '../profile/profile_model.dart';
import '../transaction/transaction_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'transaction_items_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'transaction_items_model.g.dart';

@freezed
class TransactionItemsModel with _$TransactionItemsModel {
  const factory TransactionItemsModel({
    required int id,
    @JsonKey(name: 'transactions_id') int? transactionId,
    TransactionModel? transactions,
    @JsonKey(name: 'users_id') String? userId,
    ProfileModel? profiles,
    @JsonKey(name: 'products_id') int? productsId,
    ProductModel? products,
    bool? isConfirmed,
    bool? isCancelled,
    @JsonKey(name: 'status') String? transactionItemStatus,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _TransactionItemsModel;

  factory TransactionItemsModel.fromJson(Map<String, Object?> json) =>
      _$TransactionItemsModelFromJson(json);
}
