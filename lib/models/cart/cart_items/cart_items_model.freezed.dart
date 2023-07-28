// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_items_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartItemsModel _$CartItemsModelFromJson(Map<String, dynamic> json) {
  return _CartItemsModel.fromJson(json);
}

/// @nodoc
mixin _$CartItemsModel {
  int? get id => throw _privateConstructorUsedError;
  int? get cart_id => throw _privateConstructorUsedError;
  int? get product_id => throw _privateConstructorUsedError;
  ProductModel? get products => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartItemsModelCopyWith<CartItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemsModelCopyWith<$Res> {
  factory $CartItemsModelCopyWith(
          CartItemsModel value, $Res Function(CartItemsModel) then) =
      _$CartItemsModelCopyWithImpl<$Res, CartItemsModel>;
  @useResult
  $Res call(
      {int? id,
      int? cart_id,
      int? product_id,
      ProductModel? products,
      int? quantity});

  $ProductModelCopyWith<$Res>? get products;
}

/// @nodoc
class _$CartItemsModelCopyWithImpl<$Res, $Val extends CartItemsModel>
    implements $CartItemsModelCopyWith<$Res> {
  _$CartItemsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cart_id = freezed,
    Object? product_id = freezed,
    Object? products = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cart_id: freezed == cart_id
          ? _value.cart_id
          : cart_id // ignore: cast_nullable_to_non_nullable
              as int?,
      product_id: freezed == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as int?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get products {
    if (_value.products == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.products!, (value) {
      return _then(_value.copyWith(products: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CartItemsModelCopyWith<$Res>
    implements $CartItemsModelCopyWith<$Res> {
  factory _$$_CartItemsModelCopyWith(
          _$_CartItemsModel value, $Res Function(_$_CartItemsModel) then) =
      __$$_CartItemsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? cart_id,
      int? product_id,
      ProductModel? products,
      int? quantity});

  @override
  $ProductModelCopyWith<$Res>? get products;
}

/// @nodoc
class __$$_CartItemsModelCopyWithImpl<$Res>
    extends _$CartItemsModelCopyWithImpl<$Res, _$_CartItemsModel>
    implements _$$_CartItemsModelCopyWith<$Res> {
  __$$_CartItemsModelCopyWithImpl(
      _$_CartItemsModel _value, $Res Function(_$_CartItemsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cart_id = freezed,
    Object? product_id = freezed,
    Object? products = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$_CartItemsModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cart_id: freezed == cart_id
          ? _value.cart_id
          : cart_id // ignore: cast_nullable_to_non_nullable
              as int?,
      product_id: freezed == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as int?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartItemsModel
    with DiagnosticableTreeMixin
    implements _CartItemsModel {
  const _$_CartItemsModel(
      {this.id, this.cart_id, this.product_id, this.products, this.quantity});

  factory _$_CartItemsModel.fromJson(Map<String, dynamic> json) =>
      _$$_CartItemsModelFromJson(json);

  @override
  final int? id;
  @override
  final int? cart_id;
  @override
  final int? product_id;
  @override
  final ProductModel? products;
  @override
  final int? quantity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CartItemsModel(id: $id, cart_id: $cart_id, product_id: $product_id, products: $products, quantity: $quantity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CartItemsModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('cart_id', cart_id))
      ..add(DiagnosticsProperty('product_id', product_id))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('quantity', quantity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartItemsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cart_id, cart_id) || other.cart_id == cart_id) &&
            (identical(other.product_id, product_id) ||
                other.product_id == product_id) &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, cart_id, product_id, products, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartItemsModelCopyWith<_$_CartItemsModel> get copyWith =>
      __$$_CartItemsModelCopyWithImpl<_$_CartItemsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartItemsModelToJson(
      this,
    );
  }
}

abstract class _CartItemsModel implements CartItemsModel {
  const factory _CartItemsModel(
      {final int? id,
      final int? cart_id,
      final int? product_id,
      final ProductModel? products,
      final int? quantity}) = _$_CartItemsModel;

  factory _CartItemsModel.fromJson(Map<String, dynamic> json) =
      _$_CartItemsModel.fromJson;

  @override
  int? get id;
  @override
  int? get cart_id;
  @override
  int? get product_id;
  @override
  ProductModel? get products;
  @override
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_CartItemsModelCopyWith<_$_CartItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
