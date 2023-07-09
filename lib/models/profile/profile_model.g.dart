// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfileModel _$$_ProfileModelFromJson(Map<String, dynamic> json) =>
    _$_ProfileModel(
      id: json['id'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      avatar_url: json['avatar_url'] as String?,
      isSeller: json['isSeller'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      nim: json['nim'] as String?,
      saldo: json['saldo'] as int?,
    );

Map<String, dynamic> _$$_ProfileModelToJson(_$_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatar_url': instance.avatar_url,
      'isSeller': instance.isSeller,
      'isAdmin': instance.isAdmin,
      'nim': instance.nim,
      'saldo': instance.saldo,
    };
