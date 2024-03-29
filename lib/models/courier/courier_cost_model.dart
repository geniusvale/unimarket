import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../profile/profile_model.dart';
import 'cost_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'courier_cost_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'courier_cost_model.g.dart';

@freezed
class CourierCostModel with _$CourierCostModel {
  const factory CourierCostModel({
    String? service,
    String? description,
    List<CostModel>? cost,
  }) = _CourierCostModel;

  factory CourierCostModel.fromJson(Map<String, Object?> json) =>
      _$CourierCostModelFromJson(json);
}