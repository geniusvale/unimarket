// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionModel _$$_TransactionModelFromJson(Map<String, dynamic> json) =>
    _$_TransactionModel(
      id: json['id'] as int,
      userId: json['userId'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      invoicesId: json['invoices_id'] as String?,
      quantity: json['quantity'] as int?,
      total_price: json['total_price'] as int?,
      payment_url: json['payment_url'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$_TransactionModelToJson(_$_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'invoices_id': instance.invoicesId,
      'quantity': instance.quantity,
      'total_price': instance.total_price,
      'payment_url': instance.payment_url,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
