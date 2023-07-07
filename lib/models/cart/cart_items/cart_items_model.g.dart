// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartItemsModel _$$_CartItemsModelFromJson(Map<String, dynamic> json) =>
    _$_CartItemsModel(
      id: json['id'] as int,
      cart_id: json['cart_id'] as int?,
      product_id: json['product_id'] as int?,
      products: json['products'] == null
          ? null
          : ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$$_CartItemsModelToJson(_$_CartItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cart_id': instance.cart_id,
      'product_id': instance.product_id,
      'products': instance.products,
      'quantity': instance.quantity,
    };
