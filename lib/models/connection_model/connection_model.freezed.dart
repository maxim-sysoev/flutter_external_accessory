// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'connection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConnectionModel _$ConnectionModelFromJson(Map<String, dynamic> json) {
  return _ConnectionModel.fromJson(json);
}

/// @nodoc
mixin _$ConnectionModel {
  String get connection => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionModelCopyWith<ConnectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionModelCopyWith<$Res> {
  factory $ConnectionModelCopyWith(
          ConnectionModel value, $Res Function(ConnectionModel) then) =
      _$ConnectionModelCopyWithImpl<$Res>;
  $Res call({String connection});
}

/// @nodoc
class _$ConnectionModelCopyWithImpl<$Res>
    implements $ConnectionModelCopyWith<$Res> {
  _$ConnectionModelCopyWithImpl(this._value, this._then);

  final ConnectionModel _value;
  // ignore: unused_field
  final $Res Function(ConnectionModel) _then;

  @override
  $Res call({
    Object? connection = freezed,
  }) {
    return _then(_value.copyWith(
      connection: connection == freezed
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ConnectionModelCopyWith<$Res>
    implements $ConnectionModelCopyWith<$Res> {
  factory _$$_ConnectionModelCopyWith(
          _$_ConnectionModel value, $Res Function(_$_ConnectionModel) then) =
      __$$_ConnectionModelCopyWithImpl<$Res>;
  @override
  $Res call({String connection});
}

/// @nodoc
class __$$_ConnectionModelCopyWithImpl<$Res>
    extends _$ConnectionModelCopyWithImpl<$Res>
    implements _$$_ConnectionModelCopyWith<$Res> {
  __$$_ConnectionModelCopyWithImpl(
      _$_ConnectionModel _value, $Res Function(_$_ConnectionModel) _then)
      : super(_value, (v) => _then(v as _$_ConnectionModel));

  @override
  _$_ConnectionModel get _value => super._value as _$_ConnectionModel;

  @override
  $Res call({
    Object? connection = freezed,
  }) {
    return _then(_$_ConnectionModel(
      connection: connection == freezed
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConnectionModel implements _ConnectionModel {
  const _$_ConnectionModel({required this.connection});

  factory _$_ConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$$_ConnectionModelFromJson(json);

  @override
  final String connection;

  @override
  String toString() {
    return 'ConnectionModel(connection: $connection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectionModel &&
            const DeepCollectionEquality()
                .equals(other.connection, connection));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(connection));

  @JsonKey(ignore: true)
  @override
  _$$_ConnectionModelCopyWith<_$_ConnectionModel> get copyWith =>
      __$$_ConnectionModelCopyWithImpl<_$_ConnectionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConnectionModelToJson(this);
  }
}

abstract class _ConnectionModel implements ConnectionModel {
  const factory _ConnectionModel({required final String connection}) =
      _$_ConnectionModel;

  factory _ConnectionModel.fromJson(Map<String, dynamic> json) =
      _$_ConnectionModel.fromJson;

  @override
  String get connection => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ConnectionModelCopyWith<_$_ConnectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
