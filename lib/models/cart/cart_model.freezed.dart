// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return _CartModel.fromJson(json);
}

/// @nodoc
mixin _$CartModel {
  String get id => throw _privateConstructorUsedError;
  String? get users_id => throw _privateConstructorUsedError;
  String? get total_price => throw _privateConstructorUsedError;
  String? get cart_status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartModelCopyWith<CartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartModelCopyWith<$Res> {
  factory $CartModelCopyWith(CartModel value, $Res Function(CartModel) then) =
      _$CartModelCopyWithImpl<$Res, CartModel>;
  @useResult
  $Res call(
      {String id, String? users_id, String? total_price, String? cart_status});
}

/// @nodoc
class _$CartModelCopyWithImpl<$Res, $Val extends CartModel>
    implements $CartModelCopyWith<$Res> {
  _$CartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? users_id = freezed,
    Object? total_price = freezed,
    Object? cart_status = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      users_id: freezed == users_id
          ? _value.users_id
          : users_id // ignore: cast_nullable_to_non_nullable
              as String?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as String?,
      cart_status: freezed == cart_status
          ? _value.cart_status
          : cart_status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CartModelCopyWith<$Res> implements $CartModelCopyWith<$Res> {
  factory _$$_CartModelCopyWith(
          _$_CartModel value, $Res Function(_$_CartModel) then) =
      __$$_CartModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String? users_id, String? total_price, String? cart_status});
}

/// @nodoc
class __$$_CartModelCopyWithImpl<$Res>
    extends _$CartModelCopyWithImpl<$Res, _$_CartModel>
    implements _$$_CartModelCopyWith<$Res> {
  __$$_CartModelCopyWithImpl(
      _$_CartModel _value, $Res Function(_$_CartModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? users_id = freezed,
    Object? total_price = freezed,
    Object? cart_status = freezed,
  }) {
    return _then(_$_CartModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      users_id: freezed == users_id
          ? _value.users_id
          : users_id // ignore: cast_nullable_to_non_nullable
              as String?,
      total_price: freezed == total_price
          ? _value.total_price
          : total_price // ignore: cast_nullable_to_non_nullable
              as String?,
      cart_status: freezed == cart_status
          ? _value.cart_status
          : cart_status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CartModel with DiagnosticableTreeMixin implements _CartModel {
  const _$_CartModel(
      {required this.id, this.users_id, this.total_price, this.cart_status});

  factory _$_CartModel.fromJson(Map<String, dynamic> json) =>
      _$$_CartModelFromJson(json);

  @override
  final String id;
  @override
  final String? users_id;
  @override
  final String? total_price;
  @override
  final String? cart_status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CartModel(id: $id, users_id: $users_id, total_price: $total_price, cart_status: $cart_status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CartModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('users_id', users_id))
      ..add(DiagnosticsProperty('total_price', total_price))
      ..add(DiagnosticsProperty('cart_status', cart_status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CartModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.users_id, users_id) ||
                other.users_id == users_id) &&
            (identical(other.total_price, total_price) ||
                other.total_price == total_price) &&
            (identical(other.cart_status, cart_status) ||
                other.cart_status == cart_status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, users_id, total_price, cart_status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CartModelCopyWith<_$_CartModel> get copyWith =>
      __$$_CartModelCopyWithImpl<_$_CartModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartModelToJson(
      this,
    );
  }
}

abstract class _CartModel implements CartModel {
  const factory _CartModel(
      {required final String id,
      final String? users_id,
      final String? total_price,
      final String? cart_status}) = _$_CartModel;

  factory _CartModel.fromJson(Map<String, dynamic> json) =
      _$_CartModel.fromJson;

  @override
  String get id;
  @override
  String? get users_id;
  @override
  String? get total_price;
  @override
  String? get cart_status;
  @override
  @JsonKey(ignore: true)
  _$$_CartModelCopyWith<_$_CartModel> get copyWith =>
      throw _privateConstructorUsedError;
}
