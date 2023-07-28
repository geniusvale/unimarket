// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionModel _$$_TransactionModelFromJson(Map<String, dynamic> json) =>
    _$_TransactionModel(
      id: json['id'] as int,
      userId: json['userId'] as String?,
      profiles: json['profiles'] == null
          ? null
          : ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>),
      addressId: json['address_id'] as int?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      invoicesId: json['invoices_id'] as String?,
      externalId: json['external_id'] as String?,
      quantity: json['quantity'] as int?,
      ongkir: json['ongkir'] as int?,
      shippingInfo: json['shipping_info'] as String?,
      total_price: json['total_price'] as int?,
      payment_url: json['payment_url'] as String?,
      resi: json['resi'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      transactionStatus: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      transactionItems: (json['transactions_item'] as List<dynamic>?)
          ?.map(
              (e) => TransactionItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TransactionModelToJson(_$_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'profiles': instance.profiles,
      'address_id': instance.addressId,
      'phone': instance.phone,
      'email': instance.email,
      'invoices_id': instance.invoicesId,
      'external_id': instance.externalId,
      'quantity': instance.quantity,
      'ongkir': instance.ongkir,
      'shipping_info': instance.shippingInfo,
      'total_price': instance.total_price,
      'payment_url': instance.payment_url,
      'resi': instance.resi,
      'address': instance.address,
      'status': instance.transactionStatus,
      'created_at': instance.createdAt,
      'transactions_item': instance.transactionItems,
    };
