// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  List<int>? get bioWedId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({int id, String phone, String deviceId, List<int>? bioWedId});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? deviceId = null,
    Object? bioWedId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      bioWedId: freezed == bioWedId
          ? _value.bioWedId
          : bioWedId // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String phone, String deviceId, List<int>? bioWedId});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? deviceId = null,
    Object? bioWedId = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      bioWedId: freezed == bioWedId
          ? _value._bioWedId
          : bioWedId // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.phone,
      required this.deviceId,
      required final List<int>? bioWedId})
      : _bioWedId = bioWedId;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String phone;
  @override
  final String deviceId;
  final List<int>? _bioWedId;
  @override
  List<int>? get bioWedId {
    final value = _bioWedId;
    if (value == null) return null;
    if (_bioWedId is EqualUnmodifiableListView) return _bioWedId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, deviceId: $deviceId, bioWedId: $bioWedId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            const DeepCollectionEquality().equals(other._bioWedId, _bioWedId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, phone, deviceId,
      const DeepCollectionEquality().hash(_bioWedId));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String phone,
      required final String deviceId,
      required final List<int>? bioWedId}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get phone;
  @override
  String get deviceId;
  @override
  List<int>? get bioWedId;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserTokens _$UserTokensFromJson(Map<String, dynamic> json) {
  return _UserTokens.fromJson(json);
}

/// @nodoc
mixin _$UserTokens {
  String get refreshToken => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserTokensCopyWith<UserTokens> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserTokensCopyWith<$Res> {
  factory $UserTokensCopyWith(
          UserTokens value, $Res Function(UserTokens) then) =
      _$UserTokensCopyWithImpl<$Res, UserTokens>;
  @useResult
  $Res call({String refreshToken, String accessToken});
}

/// @nodoc
class _$UserTokensCopyWithImpl<$Res, $Val extends UserTokens>
    implements $UserTokensCopyWith<$Res> {
  _$UserTokensCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refreshToken = null,
    Object? accessToken = null,
  }) {
    return _then(_value.copyWith(
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserTokensImplCopyWith<$Res>
    implements $UserTokensCopyWith<$Res> {
  factory _$$UserTokensImplCopyWith(
          _$UserTokensImpl value, $Res Function(_$UserTokensImpl) then) =
      __$$UserTokensImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refreshToken, String accessToken});
}

/// @nodoc
class __$$UserTokensImplCopyWithImpl<$Res>
    extends _$UserTokensCopyWithImpl<$Res, _$UserTokensImpl>
    implements _$$UserTokensImplCopyWith<$Res> {
  __$$UserTokensImplCopyWithImpl(
      _$UserTokensImpl _value, $Res Function(_$UserTokensImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refreshToken = null,
    Object? accessToken = null,
  }) {
    return _then(_$UserTokensImpl(
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserTokensImpl implements _UserTokens {
  const _$UserTokensImpl(
      {required this.refreshToken, required this.accessToken});

  factory _$UserTokensImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserTokensImplFromJson(json);

  @override
  final String refreshToken;
  @override
  final String accessToken;

  @override
  String toString() {
    return 'UserTokens(refreshToken: $refreshToken, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserTokensImpl &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, refreshToken, accessToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserTokensImplCopyWith<_$UserTokensImpl> get copyWith =>
      __$$UserTokensImplCopyWithImpl<_$UserTokensImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserTokensImplToJson(
      this,
    );
  }
}

abstract class _UserTokens implements UserTokens {
  const factory _UserTokens(
      {required final String refreshToken,
      required final String accessToken}) = _$UserTokensImpl;

  factory _UserTokens.fromJson(Map<String, dynamic> json) =
      _$UserTokensImpl.fromJson;

  @override
  String get refreshToken;
  @override
  String get accessToken;
  @override
  @JsonKey(ignore: true)
  _$$UserTokensImplCopyWith<_$UserTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
