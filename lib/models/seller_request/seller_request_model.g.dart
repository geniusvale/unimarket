// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SellerRequestModel _$$_SellerRequestModelFromJson(
        Map<String, dynamic> json) =>
    _$_SellerRequestModel(
      id: json['id'] as int,
      nim: json['nim'] as String?,
      phone: json['phone'] as String?,
      alamat: json['alamat'] as String?,
      city_id: json['city_id'] as String?,
      city_name: json['city_name'] as String?,
      type: json['type'] as String?,
      profiles: json['profiles'] == null
          ? null
          : ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SellerRequestModelToJson(
        _$_SellerRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nim': instance.nim,
      'phone': instance.phone,
      'alamat': instance.alamat,
      'city_id': instance.city_id,
      'city_name': instance.city_name,
      'type': instance.type,
      'profiles': instance.profiles,
    };
