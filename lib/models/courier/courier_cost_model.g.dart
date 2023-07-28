// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courier_cost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CourierCostModel _$$_CourierCostModelFromJson(Map<String, dynamic> json) =>
    _$_CourierCostModel(
      service: json['service'] as String?,
      description: json['description'] as String?,
      cost: (json['cost'] as List<dynamic>?)
          ?.map((e) => CostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CourierCostModelToJson(_$_CourierCostModel instance) =>
    <String, dynamic>{
      'service': instance.service,
      'description': instance.description,
      'cost': instance.cost,
    };
