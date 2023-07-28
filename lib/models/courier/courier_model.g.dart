// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courier_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CourierModel _$$_CourierModelFromJson(Map<String, dynamic> json) =>
    _$_CourierModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      costs: (json['costs'] as List<dynamic>?)
          ?.map((e) => CourierCostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CourierModelToJson(_$_CourierModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'costs': instance.costs,
    };
