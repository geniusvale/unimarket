// This file is "main.dart"
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../address/address_model.dart';
import '../profile/profile_model.dart';
import 'transaction_items_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'transaction_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required int id,
    String? userId,
    ProfileModel? profiles,
    @JsonKey(name: 'address_id') int? addressId,
    String? phone,
    String? email,
    @JsonKey(name: 'invoices_id') String? invoicesId,
    @JsonKey(name: 'external_id') String? externalId,
    int? quantity,
    int? ongkir,
    @JsonKey(name: 'shipping_info') String? shippingInfo,
    int? total_price,
    String? payment_url,
    String? resi,
    AddressModel? address,
    @JsonKey(name: 'status') String? transactionStatus,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'transactions_item') List<TransactionItemsModel>? transactionItems,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);
}
