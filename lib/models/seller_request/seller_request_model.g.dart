// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SellerRequestModel _$$_SellerRequestModelFromJson(
        Map<String, dynamic> json) =>
    _$_SellerRequestModel(
      id: json['id'] as int,
      profiles: json['profiles'] == null
          ? null
          : ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>),
      nim: json['nim'] as String?,
    );

Map<String, dynamic> _$$_SellerRequestModelToJson(
        _$_SellerRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profiles': instance.profiles,
      'nim': instance.nim,
    };
