// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_items_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionItemsModel _$TransactionItemsModelFromJson(
    Map<String, dynamic> json) {
  return _TransactionItemsModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionItemsModel {
  int get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  ProductModel? get products => throw _privateConstructorUsedError;
  int? get transactionId => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionItemsModelCopyWith<TransactionItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionItemsModelCopyWith<$Res> {
  factory $TransactionItemsModelCopyWith(TransactionItemsModel value,
          $Res Function(TransactionItemsModel) then) =
      _$TransactionItemsModelCopyWithImpl<$Res, TransactionItemsModel>;
  @useResult
  $Res call(
      {int id,
      String? userId,
      ProductModel? products,
      int? transactionId,
      String? createdAt});

  $ProductModelCopyWith<$Res>? get products;
}

/// @nodoc
class _$TransactionItemsModelCopyWithImpl<$Res,
        $Val extends TransactionItemsModel>
    implements $TransactionItemsModelCopyWith<$Res> {
  _$TransactionItemsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? products = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$_TransactionItemsModelCopyWith<$Res>
    implements $TransactionItemsModelCopyWith<$Res> {
  factory _$$_TransactionItemsModelCopyWith(_$_TransactionItemsModel value,
          $Res Function(_$_TransactionItemsModel) then) =
      __$$_TransactionItemsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? userId,
      ProductModel? products,
      int? transactionId,
      String? createdAt});

  @override
  $ProductModelCopyWith<$Res>? get products;
}

/// @nodoc
class __$$_TransactionItemsModelCopyWithImpl<$Res>
    extends _$TransactionItemsModelCopyWithImpl<$Res, _$_TransactionItemsModel>
    implements _$$_TransactionItemsModelCopyWith<$Res> {
  __$$_TransactionItemsModelCopyWithImpl(_$_TransactionItemsModel _value,
      $Res Function(_$_TransactionItemsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? products = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_TransactionItemsModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionItemsModel implements _TransactionItemsModel {
  const _$_TransactionItemsModel(
      {required this.id,
      this.userId,
      this.products,
      this.transactionId,
      this.createdAt});

  factory _$_TransactionItemsModel.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionItemsModelFromJson(json);

  @override
  final int id;
  @override
  final String? userId;
  @override
  final ProductModel? products;
  @override
  final int? transactionId;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'TransactionItemsModel(id: $id, userId: $userId, products: $products, transactionId: $transactionId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionItemsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, products, transactionId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionItemsModelCopyWith<_$_TransactionItemsModel> get copyWith =>
      __$$_TransactionItemsModelCopyWithImpl<_$_TransactionItemsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionItemsModelToJson(
      this,
    );
  }
}

abstract class _TransactionItemsModel implements TransactionItemsModel {
  const factory _TransactionItemsModel(
      {required final int id,
      final String? userId,
      final ProductModel? products,
      final int? transactionId,
      final String? createdAt}) = _$_TransactionItemsModel;

  factory _TransactionItemsModel.fromJson(Map<String, dynamic> json) =
      _$_TransactionItemsModel.fromJson;

  @override
  int get id;
  @override
  String? get userId;
  @override
  ProductModel? get products;
  @override
  int? get transactionId;
  @override
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionItemsModelCopyWith<_$_TransactionItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
