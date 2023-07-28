// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddressModel _$$_AddressModelFromJson(Map<String, dynamic> json) =>
    _$_AddressModel(
      id: json['id'] as int?,
      users_id: json['users_id'] as String?,
      alamat: json['alamat'] as String?,
      city_id: json['city_id'] as String?,
      city_name: json['city_name'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$_AddressModelToJson(_$_AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users_id': instance.users_id,
      'alamat': instance.alamat,
      'city_id': instance.city_id,
      'city_name': instance.city_name,
      'type': instance.type,
    };
