// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      img_url: json['img_url'] as String?,
      desc: json['desc'] as String?,
      seller_id: json['seller_id'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'img_url': instance.img_url,
      'desc': instance.desc,
      'seller_id': instance.seller_id,
      'category': instance.category,
    };
