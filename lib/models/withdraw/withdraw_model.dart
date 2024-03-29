// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../profile/profile_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'withdraw_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'withdraw_model.g.dart';

@freezed
class WithdrawModel with _$WithdrawModel {
  const factory WithdrawModel({
    required int id,
    String? users_id,
    String? payout_id,
    String? payout_url,
    String? external_id,
    int? amount,
    String? status,
    DateTime? expiration_timestamp,
    DateTime? created_at,
  }) = _WithdrawModel;

  factory WithdrawModel.fromJson(Map<String, Object?> json) =>
      _$WithdrawModelFromJson(json);
}
