// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SellerRequestModel _$SellerRequestModelFromJson(Map<String, dynamic> json) {
  return _SellerRequestModel.fromJson(json);
}

/// @nodoc
mixin _$SellerRequestModel {
  int get id => throw _privateConstructorUsedError;
  String? get users_id => throw _privateConstructorUsedError;
  String? get nim => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SellerRequestModelCopyWith<SellerRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerRequestModelCopyWith<$Res> {
  factory $SellerRequestModelCopyWith(
          SellerRequestModel value, $Res Function(SellerRequestModel) then) =
      _$SellerRequestModelCopyWithImpl<$Res, SellerRequestModel>;
  @useResult
  $Res call({int id, String? users_id, String? nim});
}

/// @nodoc
class _$SellerRequestModelCopyWithImpl<$Res, $Val extends SellerRequestModel>
    implements $SellerRequestModelCopyWith<$Res> {
  _$SellerRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? users_id = freezed,
    Object? nim = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      users_id: freezed == users_id
          ? _value.users_id
          : users_id // ignore: cast_nullable_to_non_nullable
              as String?,
      nim: freezed == nim
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SellerRequestModelCopyWith<$Res>
    implements $SellerRequestModelCopyWith<$Res> {
  factory _$$_SellerRequestModelCopyWith(_$_SellerRequestModel value,
          $Res Function(_$_SellerRequestModel) then) =
      __$$_SellerRequestModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? users_id, String? nim});
}

/// @nodoc
class __$$_SellerRequestModelCopyWithImpl<$Res>
    extends _$SellerRequestModelCopyWithImpl<$Res, _$_SellerRequestModel>
    implements _$$_SellerRequestModelCopyWith<$Res> {
  __$$_SellerRequestModelCopyWithImpl(
      _$_SellerRequestModel _value, $Res Function(_$_SellerRequestModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? users_id = freezed,
    Object? nim = freezed,
  }) {
    return _then(_$_SellerRequestModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      users_id: freezed == users_id
          ? _value.users_id
          : users_id // ignore: cast_nullable_to_non_nullable
              as String?,
      nim: freezed == nim
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SellerRequestModel
    with DiagnosticableTreeMixin
    implements _SellerRequestModel {
  const _$_SellerRequestModel({required this.id, this.users_id, this.nim});

  factory _$_SellerRequestModel.fromJson(Map<String, dynamic> json) =>
      _$$_SellerRequestModelFromJson(json);

  @override
  final int id;
  @override
  final String? users_id;
  @override
  final String? nim;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SellerRequestModel(id: $id, users_id: $users_id, nim: $nim)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SellerRequestModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('users_id', users_id))
      ..add(DiagnosticsProperty('nim', nim));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SellerRequestModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.users_id, users_id) ||
                other.users_id == users_id) &&
            (identical(other.nim, nim) || other.nim == nim));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, users_id, nim);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SellerRequestModelCopyWith<_$_SellerRequestModel> get copyWith =>
      __$$_SellerRequestModelCopyWithImpl<_$_SellerRequestModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SellerRequestModelToJson(
      this,
    );
  }
}

abstract class _SellerRequestModel implements SellerRequestModel {
  const factory _SellerRequestModel(
      {required final int id,
      final String? users_id,
      final String? nim}) = _$_SellerRequestModel;

  factory _SellerRequestModel.fromJson(Map<String, dynamic> json) =
      _$_SellerRequestModel.fromJson;

  @override
  int get id;
  @override
  String? get users_id;
  @override
  String? get nim;
  @override
  @JsonKey(ignore: true)
  _$$_SellerRequestModelCopyWith<_$_SellerRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}
