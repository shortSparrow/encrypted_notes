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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$BiometricEntityImplCopyWith<$Res>
    implements $BiometricEntityCopyWith<$Res> {
  factory _$$BiometricEntityImplCopyWith(_$BiometricEntityImpl value,
          $Res Function(_$BiometricEntityImpl) then) =
      __$$BiometricEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFaceIdSupported, bool isTouchIdSupported});
}

/// @nodoc
class __$$BiometricEntityImplCopyWithImpl<$Res>
    extends _$BiometricEntityCopyWithImpl<$Res, _$BiometricEntityImpl>
    implements _$$BiometricEntityImplCopyWith<$Res> {
  __$$BiometricEntityImplCopyWithImpl(
      _$BiometricEntityImpl _value, $Res Function(_$BiometricEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFaceIdSupported = null,
    Object? isTouchIdSupported = null,
  }) {
    return _then(_$BiometricEntityImpl(
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

class _$BiometricEntityImpl implements _BiometricEntity {
  const _$BiometricEntityImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BiometricEntityImpl &&
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
  _$$BiometricEntityImplCopyWith<_$BiometricEntityImpl> get copyWith =>
      __$$BiometricEntityImplCopyWithImpl<_$BiometricEntityImpl>(
          this, _$identity);
}

abstract class _BiometricEntity implements BiometricEntity {
  const factory _BiometricEntity(
      {required final bool isFaceIdSupported,
      required final bool isTouchIdSupported}) = _$BiometricEntityImpl;

  @override
  bool get isFaceIdSupported;
  @override
  bool get isTouchIdSupported;
  @override
  @JsonKey(ignore: true)
  _$$BiometricEntityImplCopyWith<_$BiometricEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
