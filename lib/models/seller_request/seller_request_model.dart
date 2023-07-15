// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../profile/profile_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'seller_request_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'seller_request_model.g.dart';

@freezed
class SellerRequestModel with _$SellerRequestModel {
  const factory SellerRequestModel({
    required int id,
    ProfileModel? profiles,
    String? nim,
  }) = _SellerRequestModel;

  factory SellerRequestModel.fromJson(Map<String, Object?> json) =>
      _$SellerRequestModelFromJson(json);
}
