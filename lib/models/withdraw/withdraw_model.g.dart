// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WithdrawModel _$$_WithdrawModelFromJson(Map<String, dynamic> json) =>
    _$_WithdrawModel(
      id: json['id'] as int,
      users_id: json['users_id'] as String?,
      payout_id: json['payout_id'] as String?,
      payout_url: json['payout_url'] as String?,
      external_id: json['external_id'] as String?,
      amount: json['amount'] as int?,
      status: json['status'] as String?,
      expiration_timestamp: json['expiration_timestamp'] == null
          ? null
          : DateTime.parse(json['expiration_timestamp'] as String),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_WithdrawModelToJson(_$_WithdrawModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users_id': instance.users_id,
      'payout_id': instance.payout_id,
      'payout_url': instance.payout_url,
      'external_id': instance.external_id,
      'amount': instance.amount,
      'status': instance.status,
      'expiration_timestamp': instance.expiration_timestamp?.toIso8601String(),
      'created_at': instance.created_at?.toIso8601String(),
    };
