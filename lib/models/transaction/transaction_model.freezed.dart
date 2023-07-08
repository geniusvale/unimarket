// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  int get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoices_id')
  String? get invoicesId => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  int? get total_price => throw _privateConstructorUsedError;
  String? get payment_url => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {int id,
      String? userId,
      String? address,
      String? phone,
      String? email,
      @JsonKey(name: 'invoices_id') String? invoicesId,
      int? quantity,
      int? total_price,
      String? payment_url,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? invoicesId = freezed,
    Object? quantity = freezed,
    Object? total_price = freezed,
    Object? payment_url = freezed,
    Object? status = freezed,
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
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      invoicesId: freezed == invoicesId
          ? _value.invoicesId
          : invoicesId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as int?,
      payment_url: freezed == payment_url
          ? _value.payment_url
          : payment_url // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionModelCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$_TransactionModelCopyWith(
          _$_TransactionModel value, $Res Function(_$_TransactionModel) then) =
      __$$_TransactionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? userId,
      String? address,
      String? phone,
      String? email,
      @JsonKey(name: 'invoices_id') String? invoicesId,
      int? quantity,
      int? total_price,
      String? payment_url,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt});
}

/// @nodoc
class __$$_TransactionModelCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$_TransactionModel>
    implements _$$_TransactionModelCopyWith<$Res> {
  __$$_TransactionModelCopyWithImpl(
      _$_TransactionModel _value, $Res Function(_$_TransactionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? invoicesId = freezed,
    Object? quantity = freezed,
    Object? total_price = freezed,
    Object? payment_url = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_TransactionModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      invoicesId: freezed == invoicesId
          ? _value.invoicesId
          : invoicesId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as int?,
      payment_url: freezed == payment_url
          ? _value.payment_url
          : payment_url // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
class _$_TransactionModel
    with DiagnosticableTreeMixin
    implements _TransactionModel {
  const _$_TransactionModel(
      {required this.id,
      this.userId,
      this.address,
      this.phone,
      this.email,
      @JsonKey(name: 'invoices_id') this.invoicesId,
      this.quantity,
      this.total_price,
      this.payment_url,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$_TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionModelFromJson(json);

  @override
  final int id;
  @override
  final String? userId;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'invoices_id')
  final String? invoicesId;
  @override
  final int? quantity;
  @override
  final int? total_price;
  @override
  final String? payment_url;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransactionModel(id: $id, userId: $userId, address: $address, phone: $phone, email: $email, invoicesId: $invoicesId, quantity: $quantity, total_price: $total_price, payment_url: $payment_url, status: $status, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransactionModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('invoicesId', invoicesId))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('total_price', total_price))
      ..add(DiagnosticsProperty('payment_url', payment_url))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.invoicesId, invoicesId) ||
                other.invoicesId == invoicesId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.total_price, total_price) ||
                other.total_price == total_price) &&
            (identical(other.payment_url, payment_url) ||
                other.payment_url == payment_url) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, address, phone,
      email, invoicesId, quantity, total_price, payment_url, status, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionModelCopyWith<_$_TransactionModel> get copyWith =>
      __$$_TransactionModelCopyWithImpl<_$_TransactionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionModelToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
          {required final int id,
          final String? userId,
          final String? address,
          final String? phone,
          final String? email,
          @JsonKey(name: 'invoices_id') final String? invoicesId,
          final int? quantity,
          final int? total_price,
          final String? payment_url,
          final String? status,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$_TransactionModel;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$_TransactionModel.fromJson;

  @override
  int get id;
  @override
  String? get userId;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'invoices_id')
  String? get invoicesId;
  @override
  int? get quantity;
  @override
  int? get total_price;
  @override
  String? get payment_url;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionModelCopyWith<_$_TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
