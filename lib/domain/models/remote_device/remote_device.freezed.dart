// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RemoteDevice {
  String get id =>
      throw _privateConstructorUsedError; // unique id for client on device (not the same as loadDeviceId). Must be generated by server
  SimplePublicKey get devicePublicKey => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String? get systemVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RemoteDeviceCopyWith<RemoteDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteDeviceCopyWith<$Res> {
  factory $RemoteDeviceCopyWith(
          RemoteDevice value, $Res Function(RemoteDevice) then) =
      _$RemoteDeviceCopyWithImpl<$Res, RemoteDevice>;
  @useResult
  $Res call(
      {String id,
      SimplePublicKey devicePublicKey,
      String deviceName,
      String? systemVersion});
}

/// @nodoc
class _$RemoteDeviceCopyWithImpl<$Res, $Val extends RemoteDevice>
    implements $RemoteDeviceCopyWith<$Res> {
  _$RemoteDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? devicePublicKey = null,
    Object? deviceName = null,
    Object? systemVersion = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      devicePublicKey: null == devicePublicKey
          ? _value.devicePublicKey
          : devicePublicKey // ignore: cast_nullable_to_non_nullable
              as SimplePublicKey,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      systemVersion: freezed == systemVersion
          ? _value.systemVersion
          : systemVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemoteDeviceImplCopyWith<$Res>
    implements $RemoteDeviceCopyWith<$Res> {
  factory _$$RemoteDeviceImplCopyWith(
          _$RemoteDeviceImpl value, $Res Function(_$RemoteDeviceImpl) then) =
      __$$RemoteDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SimplePublicKey devicePublicKey,
      String deviceName,
      String? systemVersion});
}

/// @nodoc
class __$$RemoteDeviceImplCopyWithImpl<$Res>
    extends _$RemoteDeviceCopyWithImpl<$Res, _$RemoteDeviceImpl>
    implements _$$RemoteDeviceImplCopyWith<$Res> {
  __$$RemoteDeviceImplCopyWithImpl(
      _$RemoteDeviceImpl _value, $Res Function(_$RemoteDeviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? devicePublicKey = null,
    Object? deviceName = null,
    Object? systemVersion = freezed,
  }) {
    return _then(_$RemoteDeviceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      devicePublicKey: null == devicePublicKey
          ? _value.devicePublicKey
          : devicePublicKey // ignore: cast_nullable_to_non_nullable
              as SimplePublicKey,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      systemVersion: freezed == systemVersion
          ? _value.systemVersion
          : systemVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RemoteDeviceImpl implements _RemoteDevice {
  const _$RemoteDeviceImpl(
      {required this.id,
      required this.devicePublicKey,
      required this.deviceName,
      required this.systemVersion});

  @override
  final String id;
// unique id for client on device (not the same as loadDeviceId). Must be generated by server
  @override
  final SimplePublicKey devicePublicKey;
  @override
  final String deviceName;
  @override
  final String? systemVersion;

  @override
  String toString() {
    return 'RemoteDevice(id: $id, devicePublicKey: $devicePublicKey, deviceName: $deviceName, systemVersion: $systemVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.devicePublicKey, devicePublicKey) ||
                other.devicePublicKey == devicePublicKey) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.systemVersion, systemVersion) ||
                other.systemVersion == systemVersion));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, devicePublicKey, deviceName, systemVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteDeviceImplCopyWith<_$RemoteDeviceImpl> get copyWith =>
      __$$RemoteDeviceImplCopyWithImpl<_$RemoteDeviceImpl>(this, _$identity);
}

abstract class _RemoteDevice implements RemoteDevice {
  const factory _RemoteDevice(
      {required final String id,
      required final SimplePublicKey devicePublicKey,
      required final String deviceName,
      required final String? systemVersion}) = _$RemoteDeviceImpl;

  @override
  String get id;
  @override // unique id for client on device (not the same as loadDeviceId). Must be generated by server
  SimplePublicKey get devicePublicKey;
  @override
  String get deviceName;
  @override
  String? get systemVersion;
  @override
  @JsonKey(ignore: true)
  _$$RemoteDeviceImplCopyWith<_$RemoteDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
