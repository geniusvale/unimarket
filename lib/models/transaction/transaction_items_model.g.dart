// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionItemsModel _$$_TransactionItemsModelFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionItemsModel(
      id: json['id'] as int,
      userId: json['users_id'] as String?,
      profiles: json['profiles'] == null
          ? null
          : ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>),
      products: json['products'] == null
          ? null
          : ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      transactionId: json['transactions_id'] as int?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$_TransactionItemsModelToJson(
        _$_TransactionItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users_id': instance.userId,
      'profiles': instance.profiles,
      'products': instance.products,
      'transactions_id': instance.transactionId,
      'created_at': instance.createdAt,
    };
