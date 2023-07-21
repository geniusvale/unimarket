// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courier_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CourierModel _$CourierModelFromJson(Map<String, dynamic> json) {
  return _CourierModel.fromJson(json);
}

/// @nodoc
mixin _$CourierModel {
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<CourierCostModel>? get costs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourierModelCopyWith<CourierModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourierModelCopyWith<$Res> {
  factory $CourierModelCopyWith(
          CourierModel value, $Res Function(CourierModel) then) =
      _$CourierModelCopyWithImpl<$Res, CourierModel>;
  @useResult
  $Res call({String? code, String? name, List<CourierCostModel>? costs});
}

/// @nodoc
class _$CourierModelCopyWithImpl<$Res, $Val extends CourierModel>
    implements $CourierModelCopyWith<$Res> {
  _$CourierModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? costs = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      costs: freezed == costs
          ? _value.costs
          : costs // ignore: cast_nullable_to_non_nullable
              as List<CourierCostModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CourierModelCopyWith<$Res>
    implements $CourierModelCopyWith<$Res> {
  factory _$$_CourierModelCopyWith(
          _$_CourierModel value, $Res Function(_$_CourierModel) then) =
      __$$_CourierModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? name, List<CourierCostModel>? costs});
}

/// @nodoc
class __$$_CourierModelCopyWithImpl<$Res>
    extends _$CourierModelCopyWithImpl<$Res, _$_CourierModel>
    implements _$$_CourierModelCopyWith<$Res> {
  __$$_CourierModelCopyWithImpl(
      _$_CourierModel _value, $Res Function(_$_CourierModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? costs = freezed,
  }) {
    return _then(_$_CourierModel(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      costs: freezed == costs
          ? _value._costs
          : costs // ignore: cast_nullable_to_non_nullable
              as List<CourierCostModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CourierModel with DiagnosticableTreeMixin implements _CourierModel {
  const _$_CourierModel(
      {this.code, this.name, final List<CourierCostModel>? costs})
      : _costs = costs;

  factory _$_CourierModel.fromJson(Map<String, dynamic> json) =>
      _$$_CourierModelFromJson(json);

  @override
  final String? code;
  @override
  final String? name;
  final List<CourierCostModel>? _costs;
  @override
  List<CourierCostModel>? get costs {
    final value = _costs;
    if (value == null) return null;
    if (_costs is EqualUnmodifiableListView) return _costs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourierModel(code: $code, name: $name, costs: $costs)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourierModel'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('costs', costs));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourierModel &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._costs, _costs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, name, const DeepCollectionEquality().hash(_costs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CourierModelCopyWith<_$_CourierModel> get copyWith =>
      __$$_CourierModelCopyWithImpl<_$_CourierModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourierModelToJson(
      this,
    );
  }
}

abstract class _CourierModel implements CourierModel {
  const factory _CourierModel(
      {final String? code,
      final String? name,
      final List<CourierCostModel>? costs}) = _$_CourierModel;

  factory _CourierModel.fromJson(Map<String, dynamic> json) =
      _$_CourierModel.fromJson;

  @override
  String? get code;
  @override
  String? get name;
  @override
  List<CourierCostModel>? get costs;
  @override
  @JsonKey(ignore: true)
  _$$_CourierModelCopyWith<_$_CourierModel> get copyWith =>
      throw _privateConstructorUsedError;
}
