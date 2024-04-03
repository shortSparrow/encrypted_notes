// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'secret_shared_preferences_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SecretSharedPreferencesData _$SecretSharedPreferencesDataFromJson(
    Map<String, dynamic> json) {
  return _SecretSharedPreferencesData.fromJson(json);
}

/// @nodoc
mixin _$SecretSharedPreferencesData {
  Map<String, Object?>? get deviceKeyPairForNotes =>
      throw _privateConstructorUsedError;
  Map<String, Object?>? get localSymmetricKey =>
      throw _privateConstructorUsedError;
  String? get webBioId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecretSharedPreferencesDataCopyWith<SecretSharedPreferencesData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretSharedPreferencesDataCopyWith<$Res> {
  factory $SecretSharedPreferencesDataCopyWith(
          SecretSharedPreferencesData value,
          $Res Function(SecretSharedPreferencesData) then) =
      _$SecretSharedPreferencesDataCopyWithImpl<$Res,
          SecretSharedPreferencesData>;
  @useResult
  $Res call(
      {Map<String, Object?>? deviceKeyPairForNotes,
      Map<String, Object?>? localSymmetricKey,
      String? webBioId});
}

/// @nodoc
class _$SecretSharedPreferencesDataCopyWithImpl<$Res,
        $Val extends SecretSharedPreferencesData>
    implements $SecretSharedPreferencesDataCopyWith<$Res> {
  _$SecretSharedPreferencesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceKeyPairForNotes = freezed,
    Object? localSymmetricKey = freezed,
    Object? webBioId = freezed,
  }) {
    return _then(_value.copyWith(
      deviceKeyPairForNotes: freezed == deviceKeyPairForNotes
          ? _value.deviceKeyPairForNotes
          : deviceKeyPairForNotes // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      localSymmetricKey: freezed == localSymmetricKey
          ? _value.localSymmetricKey
          : localSymmetricKey // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      webBioId: freezed == webBioId
          ? _value.webBioId
          : webBioId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecretSharedPreferencesDataImplCopyWith<$Res>
    implements $SecretSharedPreferencesDataCopyWith<$Res> {
  factory _$$SecretSharedPreferencesDataImplCopyWith(
          _$SecretSharedPreferencesDataImpl value,
          $Res Function(_$SecretSharedPreferencesDataImpl) then) =
      __$$SecretSharedPreferencesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Object?>? deviceKeyPairForNotes,
      Map<String, Object?>? localSymmetricKey,
      String? webBioId});
}

/// @nodoc
class __$$SecretSharedPreferencesDataImplCopyWithImpl<$Res>
    extends _$SecretSharedPreferencesDataCopyWithImpl<$Res,
        _$SecretSharedPreferencesDataImpl>
    implements _$$SecretSharedPreferencesDataImplCopyWith<$Res> {
  __$$SecretSharedPreferencesDataImplCopyWithImpl(
      _$SecretSharedPreferencesDataImpl _value,
      $Res Function(_$SecretSharedPreferencesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceKeyPairForNotes = freezed,
    Object? localSymmetricKey = freezed,
    Object? webBioId = freezed,
  }) {
    return _then(_$SecretSharedPreferencesDataImpl(
      deviceKeyPairForNotes: freezed == deviceKeyPairForNotes
          ? _value._deviceKeyPairForNotes
          : deviceKeyPairForNotes // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      localSymmetricKey: freezed == localSymmetricKey
          ? _value._localSymmetricKey
          : localSymmetricKey // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      webBioId: freezed == webBioId
          ? _value.webBioId
          : webBioId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecretSharedPreferencesDataImpl
    implements _SecretSharedPreferencesData {
  _$SecretSharedPreferencesDataImpl(
      {required final Map<String, Object?>? deviceKeyPairForNotes,
      required final Map<String, Object?>? localSymmetricKey,
      required this.webBioId})
      : _deviceKeyPairForNotes = deviceKeyPairForNotes,
        _localSymmetricKey = localSymmetricKey;

  factory _$SecretSharedPreferencesDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SecretSharedPreferencesDataImplFromJson(json);

  final Map<String, Object?>? _deviceKeyPairForNotes;
  @override
  Map<String, Object?>? get deviceKeyPairForNotes {
    final value = _deviceKeyPairForNotes;
    if (value == null) return null;
    if (_deviceKeyPairForNotes is EqualUnmodifiableMapView)
      return _deviceKeyPairForNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, Object?>? _localSymmetricKey;
  @override
  Map<String, Object?>? get localSymmetricKey {
    final value = _localSymmetricKey;
    if (value == null) return null;
    if (_localSymmetricKey is EqualUnmodifiableMapView)
      return _localSymmetricKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? webBioId;

  @override
  String toString() {
    return 'SecretSharedPreferencesData(deviceKeyPairForNotes: $deviceKeyPairForNotes, localSymmetricKey: $localSymmetricKey, webBioId: $webBioId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecretSharedPreferencesDataImpl &&
            const DeepCollectionEquality()
                .equals(other._deviceKeyPairForNotes, _deviceKeyPairForNotes) &&
            const DeepCollectionEquality()
                .equals(other._localSymmetricKey, _localSymmetricKey) &&
            (identical(other.webBioId, webBioId) ||
                other.webBioId == webBioId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_deviceKeyPairForNotes),
      const DeepCollectionEquality().hash(_localSymmetricKey),
      webBioId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecretSharedPreferencesDataImplCopyWith<_$SecretSharedPreferencesDataImpl>
      get copyWith => __$$SecretSharedPreferencesDataImplCopyWithImpl<
          _$SecretSharedPreferencesDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecretSharedPreferencesDataImplToJson(
      this,
    );
  }
}

abstract class _SecretSharedPreferencesData
    implements SecretSharedPreferencesData {
  factory _SecretSharedPreferencesData(
      {required final Map<String, Object?>? deviceKeyPairForNotes,
      required final Map<String, Object?>? localSymmetricKey,
      required final String? webBioId}) = _$SecretSharedPreferencesDataImpl;

  factory _SecretSharedPreferencesData.fromJson(Map<String, dynamic> json) =
      _$SecretSharedPreferencesDataImpl.fromJson;

  @override
  Map<String, Object?>? get deviceKeyPairForNotes;
  @override
  Map<String, Object?>? get localSymmetricKey;
  @override
  String? get webBioId;
  @override
  @JsonKey(ignore: true)
  _$$SecretSharedPreferencesDataImplCopyWith<_$SecretSharedPreferencesDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
