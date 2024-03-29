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
  @JsonKey(name: 'transactions_id')
  int? get transactionId => throw _privateConstructorUsedError;
  TransactionModel? get transactions => throw _privateConstructorUsedError;
  @JsonKey(name: 'users_id')
  String? get userId => throw _privateConstructorUsedError;
  ProfileModel? get profiles => throw _privateConstructorUsedError;
  @JsonKey(name: 'products_id')
  int? get productsId => throw _privateConstructorUsedError;
  ProductModel? get products => throw _privateConstructorUsedError;
  bool? get isConfirmed => throw _privateConstructorUsedError;
  bool? get isCancelled => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String? get transactionItemStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
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
      @JsonKey(name: 'transactions_id') int? transactionId,
      TransactionModel? transactions,
      @JsonKey(name: 'users_id') String? userId,
      ProfileModel? profiles,
      @JsonKey(name: 'products_id') int? productsId,
      ProductModel? products,
      bool? isConfirmed,
      bool? isCancelled,
      @JsonKey(name: 'status') String? transactionItemStatus,
      @JsonKey(name: 'created_at') String? createdAt});

  $TransactionModelCopyWith<$Res>? get transactions;
  $ProfileModelCopyWith<$Res>? get profiles;
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
    Object? transactionId = freezed,
    Object? transactions = freezed,
    Object? userId = freezed,
    Object? profiles = freezed,
    Object? productsId = freezed,
    Object? products = freezed,
    Object? isConfirmed = freezed,
    Object? isCancelled = freezed,
    Object? transactionItemStatus = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      transactions: freezed == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as TransactionModel?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profiles: freezed == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      productsId: freezed == productsId
          ? _value.productsId
          : productsId // ignore: cast_nullable_to_non_nullable
              as int?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      isConfirmed: freezed == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCancelled: freezed == isCancelled
          ? _value.isCancelled
          : isCancelled // ignore: cast_nullable_to_non_nullable
              as bool?,
      transactionItemStatus: freezed == transactionItemStatus
          ? _value.transactionItemStatus
          : transactionItemStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionModelCopyWith<$Res>? get transactions {
    if (_value.transactions == null) {
      return null;
    }

    return $TransactionModelCopyWith<$Res>(_value.transactions!, (value) {
      return _then(_value.copyWith(transactions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res>? get profiles {
    if (_value.profiles == null) {
      return null;
    }

    return $ProfileModelCopyWith<$Res>(_value.profiles!, (value) {
      return _then(_value.copyWith(profiles: value) as $Val);
    });
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
      @JsonKey(name: 'transactions_id') int? transactionId,
      TransactionModel? transactions,
      @JsonKey(name: 'users_id') String? userId,
      ProfileModel? profiles,
      @JsonKey(name: 'products_id') int? productsId,
      ProductModel? products,
      bool? isConfirmed,
      bool? isCancelled,
      @JsonKey(name: 'status') String? transactionItemStatus,
      @JsonKey(name: 'created_at') String? createdAt});

  @override
  $TransactionModelCopyWith<$Res>? get transactions;
  @override
  $ProfileModelCopyWith<$Res>? get profiles;
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
    Object? transactionId = freezed,
    Object? transactions = freezed,
    Object? userId = freezed,
    Object? profiles = freezed,
    Object? productsId = freezed,
    Object? products = freezed,
    Object? isConfirmed = freezed,
    Object? isCancelled = freezed,
    Object? transactionItemStatus = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_TransactionItemsModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      transactions: freezed == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as TransactionModel?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profiles: freezed == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      productsId: freezed == productsId
          ? _value.productsId
          : productsId // ignore: cast_nullable_to_non_nullable
              as int?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      isConfirmed: freezed == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCancelled: freezed == isCancelled
          ? _value.isCancelled
          : isCancelled // ignore: cast_nullable_to_non_nullable
              as bool?,
      transactionItemStatus: freezed == transactionItemStatus
          ? _value.transactionItemStatus
          : transactionItemStatus // ignore: cast_nullable_to_non_nullable
              as String?,
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
      @JsonKey(name: 'transactions_id') this.transactionId,
      this.transactions,
      @JsonKey(name: 'users_id') this.userId,
      this.profiles,
      @JsonKey(name: 'products_id') this.productsId,
      this.products,
      this.isConfirmed,
      this.isCancelled,
      @JsonKey(name: 'status') this.transactionItemStatus,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$_TransactionItemsModel.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionItemsModelFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'transactions_id')
  final int? transactionId;
  @override
  final TransactionModel? transactions;
  @override
  @JsonKey(name: 'users_id')
  final String? userId;
  @override
  final ProfileModel? profiles;
  @override
  @JsonKey(name: 'products_id')
  final int? productsId;
  @override
  final ProductModel? products;
  @override
  final bool? isConfirmed;
  @override
  final bool? isCancelled;
  @override
  @JsonKey(name: 'status')
  final String? transactionItemStatus;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'TransactionItemsModel(id: $id, transactionId: $transactionId, transactions: $transactions, userId: $userId, profiles: $profiles, productsId: $productsId, products: $products, isConfirmed: $isConfirmed, isCancelled: $isCancelled, transactionItemStatus: $transactionItemStatus, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionItemsModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.transactions, transactions) ||
                other.transactions == transactions) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.profiles, profiles) ||
                other.profiles == profiles) &&
            (identical(other.productsId, productsId) ||
                other.productsId == productsId) &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed) &&
            (identical(other.isCancelled, isCancelled) ||
                other.isCancelled == isCancelled) &&
            (identical(other.transactionItemStatus, transactionItemStatus) ||
                other.transactionItemStatus == transactionItemStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      transactionId,
      transactions,
      userId,
      profiles,
      productsId,
      products,
      isConfirmed,
      isCancelled,
      transactionItemStatus,
      createdAt);

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
          @JsonKey(name: 'transactions_id') final int? transactionId,
          final TransactionModel? transactions,
          @JsonKey(name: 'users_id') final String? userId,
          final ProfileModel? profiles,
          @JsonKey(name: 'products_id') final int? productsId,
          final ProductModel? products,
          final bool? isConfirmed,
          final bool? isCancelled,
          @JsonKey(name: 'status') final String? transactionItemStatus,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$_TransactionItemsModel;

  factory _TransactionItemsModel.fromJson(Map<String, dynamic> json) =
      _$_TransactionItemsModel.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'transactions_id')
  int? get transactionId;
  @override
  TransactionModel? get transactions;
  @override
  @JsonKey(name: 'users_id')
  String? get userId;
  @override
  ProfileModel? get profiles;
  @override
  @JsonKey(name: 'products_id')
  int? get productsId;
  @override
  ProductModel? get products;
  @override
  bool? get isConfirmed;
  @override
  bool? get isCancelled;
  @override
  @JsonKey(name: 'status')
  String? get transactionItemStatus;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionItemsModelCopyWith<_$_TransactionItemsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
