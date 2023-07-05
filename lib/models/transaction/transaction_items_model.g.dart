// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionItemsModel _$$_TransactionItemsModelFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionItemsModel(
      id: json['id'] as int,
      userId: json['userId'] as String?,
      products: json['products'] == null
          ? null
          : ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as int?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$_TransactionItemsModelToJson(
        _$_TransactionItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'products': instance.products,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt,
    };
