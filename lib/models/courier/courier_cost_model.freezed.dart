// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courier_cost_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CourierCostModel _$CourierCostModelFromJson(Map<String, dynamic> json) {
  return _CourierCostModel.fromJson(json);
}

/// @nodoc
mixin _$CourierCostModel {
  String? get service => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<CostModel>? get cost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourierCostModelCopyWith<CourierCostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourierCostModelCopyWith<$Res> {
  factory $CourierCostModelCopyWith(
          CourierCostModel value, $Res Function(CourierCostModel) then) =
      _$CourierCostModelCopyWithImpl<$Res, CourierCostModel>;
  @useResult
  $Res call({String? service, String? description, List<CostModel>? cost});
}

/// @nodoc
class _$CourierCostModelCopyWithImpl<$Res, $Val extends CourierCostModel>
    implements $CourierCostModelCopyWith<$Res> {
  _$CourierCostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = freezed,
    Object? description = freezed,
    Object? cost = freezed,
  }) {
    return _then(_value.copyWith(
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as List<CostModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CourierCostModelCopyWith<$Res>
    implements $CourierCostModelCopyWith<$Res> {
  factory _$$_CourierCostModelCopyWith(
          _$_CourierCostModel value, $Res Function(_$_CourierCostModel) then) =
      __$$_CourierCostModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? service, String? description, List<CostModel>? cost});
}

/// @nodoc
class __$$_CourierCostModelCopyWithImpl<$Res>
    extends _$CourierCostModelCopyWithImpl<$Res, _$_CourierCostModel>
    implements _$$_CourierCostModelCopyWith<$Res> {
  __$$_CourierCostModelCopyWithImpl(
      _$_CourierCostModel _value, $Res Function(_$_CourierCostModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = freezed,
    Object? description = freezed,
    Object? cost = freezed,
  }) {
    return _then(_$_CourierCostModel(
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: freezed == cost
          ? _value._cost
          : cost // ignore: cast_nullable_to_non_nullable
              as List<CostModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CourierCostModel
    with DiagnosticableTreeMixin
    implements _CourierCostModel {
  const _$_CourierCostModel(
      {this.service, this.description, final List<CostModel>? cost})
      : _cost = cost;

  factory _$_CourierCostModel.fromJson(Map<String, dynamic> json) =>
      _$$_CourierCostModelFromJson(json);

  @override
  final String? service;
  @override
  final String? description;
  final List<CostModel>? _cost;
  @override
  List<CostModel>? get cost {
    final value = _cost;
    if (value == null) return null;
    if (_cost is EqualUnmodifiableListView) return _cost;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourierCostModel(service: $service, description: $description, cost: $cost)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourierCostModel'))
      ..add(DiagnosticsProperty('service', service))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('cost', cost));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourierCostModel &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._cost, _cost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, service, description,
      const DeepCollectionEquality().hash(_cost));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CourierCostModelCopyWith<_$_CourierCostModel> get copyWith =>
      __$$_CourierCostModelCopyWithImpl<_$_CourierCostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourierCostModelToJson(
      this,
    );
  }
}

abstract class _CourierCostModel implements CourierCostModel {
  const factory _CourierCostModel(
      {final String? service,
      final String? description,
      final List<CostModel>? cost}) = _$_CourierCostModel;

  factory _CourierCostModel.fromJson(Map<String, dynamic> json) =
      _$_CourierCostModel.fromJson;

  @override
  String? get service;
  @override
  String? get description;
  @override
  List<CostModel>? get cost;
  @override
  @JsonKey(ignore: true)
  _$$_CourierCostModelCopyWith<_$_CourierCostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
