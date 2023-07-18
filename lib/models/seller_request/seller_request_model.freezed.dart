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
  String? get nim => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get alamat => throw _privateConstructorUsedError;
  String? get city_id => throw _privateConstructorUsedError;
  String? get city_name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  ProfileModel? get profiles => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      String? nim,
      String? phone,
      String? alamat,
      String? city_id,
      String? city_name,
      String? type,
      ProfileModel? profiles});

  $ProfileModelCopyWith<$Res>? get profiles;
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
    Object? nim = freezed,
    Object? phone = freezed,
    Object? alamat = freezed,
    Object? city_id = freezed,
    Object? city_name = freezed,
    Object? type = freezed,
    Object? profiles = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nim: freezed == nim
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      alamat: freezed == alamat
          ? _value.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String?,
      city_id: freezed == city_id
          ? _value.city_id
          : city_id // ignore: cast_nullable_to_non_nullable
              as String?,
      city_name: freezed == city_name
          ? _value.city_name
          : city_name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      profiles: freezed == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
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
}

/// @nodoc
abstract class _$$_SellerRequestModelCopyWith<$Res>
    implements $SellerRequestModelCopyWith<$Res> {
  factory _$$_SellerRequestModelCopyWith(_$_SellerRequestModel value,
          $Res Function(_$_SellerRequestModel) then) =
      __$$_SellerRequestModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? nim,
      String? phone,
      String? alamat,
      String? city_id,
      String? city_name,
      String? type,
      ProfileModel? profiles});

  @override
  $ProfileModelCopyWith<$Res>? get profiles;
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
    Object? nim = freezed,
    Object? phone = freezed,
    Object? alamat = freezed,
    Object? city_id = freezed,
    Object? city_name = freezed,
    Object? type = freezed,
    Object? profiles = freezed,
  }) {
    return _then(_$_SellerRequestModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nim: freezed == nim
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      alamat: freezed == alamat
          ? _value.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String?,
      city_id: freezed == city_id
          ? _value.city_id
          : city_id // ignore: cast_nullable_to_non_nullable
              as String?,
      city_name: freezed == city_name
          ? _value.city_name
          : city_name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      profiles: freezed == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as ProfileModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SellerRequestModel
    with DiagnosticableTreeMixin
    implements _SellerRequestModel {
  const _$_SellerRequestModel(
      {required this.id,
      this.nim,
      this.phone,
      this.alamat,
      this.city_id,
      this.city_name,
      this.type,
      this.profiles});

  factory _$_SellerRequestModel.fromJson(Map<String, dynamic> json) =>
      _$$_SellerRequestModelFromJson(json);

  @override
  final int id;
  @override
  final String? nim;
  @override
  final String? phone;
  @override
  final String? alamat;
  @override
  final String? city_id;
  @override
  final String? city_name;
  @override
  final String? type;
  @override
  final ProfileModel? profiles;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SellerRequestModel(id: $id, nim: $nim, phone: $phone, alamat: $alamat, city_id: $city_id, city_name: $city_name, type: $type, profiles: $profiles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SellerRequestModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('nim', nim))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('alamat', alamat))
      ..add(DiagnosticsProperty('city_id', city_id))
      ..add(DiagnosticsProperty('city_name', city_name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('profiles', profiles));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SellerRequestModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nim, nim) || other.nim == nim) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.alamat, alamat) || other.alamat == alamat) &&
            (identical(other.city_id, city_id) || other.city_id == city_id) &&
            (identical(other.city_name, city_name) ||
                other.city_name == city_name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.profiles, profiles) ||
                other.profiles == profiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, nim, phone, alamat, city_id, city_name, type, profiles);

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
      final String? nim,
      final String? phone,
      final String? alamat,
      final String? city_id,
      final String? city_name,
      final String? type,
      final ProfileModel? profiles}) = _$_SellerRequestModel;

  factory _SellerRequestModel.fromJson(Map<String, dynamic> json) =
      _$_SellerRequestModel.fromJson;

  @override
  int get id;
  @override
  String? get nim;
  @override
  String? get phone;
  @override
  String? get alamat;
  @override
  String? get city_id;
  @override
  String? get city_name;
  @override
  String? get type;
  @override
  ProfileModel? get profiles;
  @override
  @JsonKey(ignore: true)
  _$$_SellerRequestModelCopyWith<_$_SellerRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}
