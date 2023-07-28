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
  ProfileModel? get profiles => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_id')
  int? get addressId => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoices_id')
  String? get invoicesId => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_id')
  String? get externalId => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  int? get ongkir => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipping_info')
  String? get shippingInfo => throw _privateConstructorUsedError;
  int? get total_price => throw _privateConstructorUsedError;
  String? get payment_url => throw _privateConstructorUsedError;
  String? get resi => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String? get transactionStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'transactions_item')
  List<TransactionItemsModel>? get transactionItems =>
      throw _privateConstructorUsedError;

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
      ProfileModel? profiles,
      @JsonKey(name: 'address_id')
          int? addressId,
      String? phone,
      String? email,
      @JsonKey(name: 'invoices_id')
          String? invoicesId,
      @JsonKey(name: 'external_id')
          String? externalId,
      int? quantity,
      int? ongkir,
      @JsonKey(name: 'shipping_info')
          String? shippingInfo,
      int? total_price,
      String? payment_url,
      String? resi,
      AddressModel? address,
      @JsonKey(name: 'status')
          String? transactionStatus,
      @JsonKey(name: 'created_at')
          String? createdAt,
      @JsonKey(name: 'transactions_item')
          List<TransactionItemsModel>? transactionItems});

  $ProfileModelCopyWith<$Res>? get profiles;
  $AddressModelCopyWith<$Res>? get address;
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
    Object? profiles = freezed,
    Object? addressId = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? invoicesId = freezed,
    Object? externalId = freezed,
    Object? quantity = freezed,
    Object? ongkir = freezed,
    Object? shippingInfo = freezed,
    Object? total_price = freezed,
    Object? payment_url = freezed,
    Object? resi = freezed,
    Object? address = freezed,
    Object? transactionStatus = freezed,
    Object? createdAt = freezed,
    Object? transactionItems = freezed,
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
      profiles: freezed == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      ongkir: freezed == ongkir
          ? _value.ongkir
          : ongkir // ignore: cast_nullable_to_non_nullable
              as int?,
      shippingInfo: freezed == shippingInfo
          ? _value.shippingInfo
          : shippingInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as int?,
      payment_url: freezed == payment_url
          ? _value.payment_url
          : payment_url // ignore: cast_nullable_to_non_nullable
              as String?,
      resi: freezed == resi
          ? _value.resi
          : resi // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      transactionStatus: freezed == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionItems: freezed == transactionItems
          ? _value.transactionItems
          : transactionItems // ignore: cast_nullable_to_non_nullable
              as List<TransactionItemsModel>?,
    ) as $Val);
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
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
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
      ProfileModel? profiles,
      @JsonKey(name: 'address_id')
          int? addressId,
      String? phone,
      String? email,
      @JsonKey(name: 'invoices_id')
          String? invoicesId,
      @JsonKey(name: 'external_id')
          String? externalId,
      int? quantity,
      int? ongkir,
      @JsonKey(name: 'shipping_info')
          String? shippingInfo,
      int? total_price,
      String? payment_url,
      String? resi,
      AddressModel? address,
      @JsonKey(name: 'status')
          String? transactionStatus,
      @JsonKey(name: 'created_at')
          String? createdAt,
      @JsonKey(name: 'transactions_item')
          List<TransactionItemsModel>? transactionItems});

  @override
  $ProfileModelCopyWith<$Res>? get profiles;
  @override
  $AddressModelCopyWith<$Res>? get address;
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
    Object? profiles = freezed,
    Object? addressId = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? invoicesId = freezed,
    Object? externalId = freezed,
    Object? quantity = freezed,
    Object? ongkir = freezed,
    Object? shippingInfo = freezed,
    Object? total_price = freezed,
    Object? payment_url = freezed,
    Object? resi = freezed,
    Object? address = freezed,
    Object? transactionStatus = freezed,
    Object? createdAt = freezed,
    Object? transactionItems = freezed,
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
      profiles: freezed == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      externalId: freezed == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      ongkir: freezed == ongkir
          ? _value.ongkir
          : ongkir // ignore: cast_nullable_to_non_nullable
              as int?,
      shippingInfo: freezed == shippingInfo
          ? _value.shippingInfo
          : shippingInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as int?,
      payment_url: freezed == payment_url
          ? _value.payment_url
          : payment_url // ignore: cast_nullable_to_non_nullable
              as String?,
      resi: freezed == resi
          ? _value.resi
          : resi // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      transactionStatus: freezed == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionItems: freezed == transactionItems
          ? _value._transactionItems
          : transactionItems // ignore: cast_nullable_to_non_nullable
              as List<TransactionItemsModel>?,
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
      this.profiles,
      @JsonKey(name: 'address_id')
          this.addressId,
      this.phone,
      this.email,
      @JsonKey(name: 'invoices_id')
          this.invoicesId,
      @JsonKey(name: 'external_id')
          this.externalId,
      this.quantity,
      this.ongkir,
      @JsonKey(name: 'shipping_info')
          this.shippingInfo,
      this.total_price,
      this.payment_url,
      this.resi,
      this.address,
      @JsonKey(name: 'status')
          this.transactionStatus,
      @JsonKey(name: 'created_at')
          this.createdAt,
      @JsonKey(name: 'transactions_item')
          final List<TransactionItemsModel>? transactionItems})
      : _transactionItems = transactionItems;

  factory _$_TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionModelFromJson(json);

  @override
  final int id;
  @override
  final String? userId;
  @override
  final ProfileModel? profiles;
  @override
  @JsonKey(name: 'address_id')
  final int? addressId;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'invoices_id')
  final String? invoicesId;
  @override
  @JsonKey(name: 'external_id')
  final String? externalId;
  @override
  final int? quantity;
  @override
  final int? ongkir;
  @override
  @JsonKey(name: 'shipping_info')
  final String? shippingInfo;
  @override
  final int? total_price;
  @override
  final String? payment_url;
  @override
  final String? resi;
  @override
  final AddressModel? address;
  @override
  @JsonKey(name: 'status')
  final String? transactionStatus;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final List<TransactionItemsModel>? _transactionItems;
  @override
  @JsonKey(name: 'transactions_item')
  List<TransactionItemsModel>? get transactionItems {
    final value = _transactionItems;
    if (value == null) return null;
    if (_transactionItems is EqualUnmodifiableListView)
      return _transactionItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransactionModel(id: $id, userId: $userId, profiles: $profiles, addressId: $addressId, phone: $phone, email: $email, invoicesId: $invoicesId, externalId: $externalId, quantity: $quantity, ongkir: $ongkir, shippingInfo: $shippingInfo, total_price: $total_price, payment_url: $payment_url, resi: $resi, address: $address, transactionStatus: $transactionStatus, createdAt: $createdAt, transactionItems: $transactionItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransactionModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('profiles', profiles))
      ..add(DiagnosticsProperty('addressId', addressId))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('invoicesId', invoicesId))
      ..add(DiagnosticsProperty('externalId', externalId))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('ongkir', ongkir))
      ..add(DiagnosticsProperty('shippingInfo', shippingInfo))
      ..add(DiagnosticsProperty('total_price', total_price))
      ..add(DiagnosticsProperty('payment_url', payment_url))
      ..add(DiagnosticsProperty('resi', resi))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('transactionStatus', transactionStatus))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('transactionItems', transactionItems));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.profiles, profiles) ||
                other.profiles == profiles) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.invoicesId, invoicesId) ||
                other.invoicesId == invoicesId) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.ongkir, ongkir) || other.ongkir == ongkir) &&
            (identical(other.shippingInfo, shippingInfo) ||
                other.shippingInfo == shippingInfo) &&
            (identical(other.total_price, total_price) ||
                other.total_price == total_price) &&
            (identical(other.payment_url, payment_url) ||
                other.payment_url == payment_url) &&
            (identical(other.resi, resi) || other.resi == resi) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.transactionStatus, transactionStatus) ||
                other.transactionStatus == transactionStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._transactionItems, _transactionItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      profiles,
      addressId,
      phone,
      email,
      invoicesId,
      externalId,
      quantity,
      ongkir,
      shippingInfo,
      total_price,
      payment_url,
      resi,
      address,
      transactionStatus,
      createdAt,
      const DeepCollectionEquality().hash(_transactionItems));

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
          final ProfileModel? profiles,
          @JsonKey(name: 'address_id')
              final int? addressId,
          final String? phone,
          final String? email,
          @JsonKey(name: 'invoices_id')
              final String? invoicesId,
          @JsonKey(name: 'external_id')
              final String? externalId,
          final int? quantity,
          final int? ongkir,
          @JsonKey(name: 'shipping_info')
              final String? shippingInfo,
          final int? total_price,
          final String? payment_url,
          final String? resi,
          final AddressModel? address,
          @JsonKey(name: 'status')
              final String? transactionStatus,
          @JsonKey(name: 'created_at')
              final String? createdAt,
          @JsonKey(name: 'transactions_item')
              final List<TransactionItemsModel>? transactionItems}) =
      _$_TransactionModel;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$_TransactionModel.fromJson;

  @override
  int get id;
  @override
  String? get userId;
  @override
  ProfileModel? get profiles;
  @override
  @JsonKey(name: 'address_id')
  int? get addressId;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'invoices_id')
  String? get invoicesId;
  @override
  @JsonKey(name: 'external_id')
  String? get externalId;
  @override
  int? get quantity;
  @override
  int? get ongkir;
  @override
  @JsonKey(name: 'shipping_info')
  String? get shippingInfo;
  @override
  int? get total_price;
  @override
  String? get payment_url;
  @override
  String? get resi;
  @override
  AddressModel? get address;
  @override
  @JsonKey(name: 'status')
  String? get transactionStatus;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'transactions_item')
  List<TransactionItemsModel>? get transactionItems;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionModelCopyWith<_$_TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
