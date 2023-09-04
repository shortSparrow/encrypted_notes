// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BiometricEntity {
  bool get isFaceIdSupported => throw _privateConstructorUsedError;
  bool get isTouchIdSupported => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BiometricEntityCopyWith<BiometricEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BiometricEntityCopyWith<$Res> {
  factory $BiometricEntityCopyWith(
          BiometricEntity value, $Res Function(BiometricEntity) then) =
      _$BiometricEntityCopyWithImpl<$Res, BiometricEntity>;
  @useResult
  $Res call({bool isFaceIdSupported, bool isTouchIdSupported});
}

/// @nodoc
class _$BiometricEntityCopyWithImpl<$Res, $Val extends BiometricEntity>
    implements $BiometricEntityCopyWith<$Res> {
  _$BiometricEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFaceIdSupported = null,
    Object? isTouchIdSupported = null,
  }) {
    return _then(_value.copyWith(
      isFaceIdSupported: null == isFaceIdSupported
          ? _value.isFaceIdSupported
          : isFaceIdSupported // ignore: cast_nullable_to_non_nullable
              as bool,
      isTouchIdSupported: null == isTouchIdSupported
          ? _value.isTouchIdSupported
          : isTouchIdSupported // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BiometricEntityCopyWith<$Res>
    implements $BiometricEntityCopyWith<$Res> {
  factory _$$_BiometricEntityCopyWith(
          _$_BiometricEntity value, $Res Function(_$_BiometricEntity) then) =
      __$$_BiometricEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFaceIdSupported, bool isTouchIdSupported});
}

/// @nodoc
class __$$_BiometricEntityCopyWithImpl<$Res>
    extends _$BiometricEntityCopyWithImpl<$Res, _$_BiometricEntity>
    implements _$$_BiometricEntityCopyWith<$Res> {
  __$$_BiometricEntityCopyWithImpl(
      _$_BiometricEntity _value, $Res Function(_$_BiometricEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFaceIdSupported = null,
    Object? isTouchIdSupported = null,
  }) {
    return _then(_$_BiometricEntity(
      isFaceIdSupported: null == isFaceIdSupported
          ? _value.isFaceIdSupported
          : isFaceIdSupported // ignore: cast_nullable_to_non_nullable
              as bool,
      isTouchIdSupported: null == isTouchIdSupported
          ? _value.isTouchIdSupported
          : isTouchIdSupported // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BiometricEntity implements _BiometricEntity {
  const _$_BiometricEntity(
      {required this.isFaceIdSupported, required this.isTouchIdSupported});

  @override
  final bool isFaceIdSupported;
  @override
  final bool isTouchIdSupported;

  @override
  String toString() {
    return 'BiometricEntity(isFaceIdSupported: $isFaceIdSupported, isTouchIdSupported: $isTouchIdSupported)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BiometricEntity &&
            (identical(other.isFaceIdSupported, isFaceIdSupported) ||
                other.isFaceIdSupported == isFaceIdSupported) &&
            (identical(other.isTouchIdSupported, isTouchIdSupported) ||
                other.isTouchIdSupported == isTouchIdSupported));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isFaceIdSupported, isTouchIdSupported);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BiometricEntityCopyWith<_$_BiometricEntity> get copyWith =>
      __$$_BiometricEntityCopyWithImpl<_$_BiometricEntity>(this, _$identity);
}

abstract class _BiometricEntity implements BiometricEntity {
  const factory _BiometricEntity(
      {required final bool isFaceIdSupported,
      required final bool isTouchIdSupported}) = _$_BiometricEntity;

  @override
  bool get isFaceIdSupported;
  @override
  bool get isTouchIdSupported;
  @override
  @JsonKey(ignore: true)
  _$$_BiometricEntityCopyWith<_$_BiometricEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
