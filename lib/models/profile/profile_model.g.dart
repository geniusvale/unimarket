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
    );

Map<String, dynamic> _$$_ProfileModelToJson(_$_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatar_url': instance.avatar_url,
      'isSeller': instance.isSeller,
    };
