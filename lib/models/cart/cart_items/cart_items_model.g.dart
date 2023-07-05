// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartItemsModel _$$_CartItemsModelFromJson(Map<String, dynamic> json) =>
    _$_CartItemsModel(
      id: json['id'] as String,
      cart_id: json['cart_id'] as String?,
      product_id: json['product_id'] == null
          ? null
          : ProductModel.fromJson(json['product_id'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
    );

Map<String, dynamic> _$$_CartItemsModelToJson(_$_CartItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cart_id': instance.cart_id,
      'product_id': instance.product_id,
      'quantity': instance.quantity,
    };
