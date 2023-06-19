// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SellerRequestModel _$$_SellerRequestModelFromJson(
        Map<String, dynamic> json) =>
    _$_SellerRequestModel(
      id: json['id'] as int,
      users_id: json['users_id'] as String?,
      nim: json['nim'] as String?,
    );

Map<String, dynamic> _$$_SellerRequestModelToJson(
        _$_SellerRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users_id': instance.users_id,
      'nim': instance.nim,
    };
