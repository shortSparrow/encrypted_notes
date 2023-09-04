// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combined_local_remote_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CombinedLocalRemoteResponse<Local, Remote> {
  Remote get remote => throw _privateConstructorUsedError;
  Local get local => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CombinedLocalRemoteResponseCopyWith<Local, Remote,
          CombinedLocalRemoteResponse<Local, Remote>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CombinedLocalRemoteResponseCopyWith<Local, Remote, $Res> {
  factory $CombinedLocalRemoteResponseCopyWith(
          CombinedLocalRemoteResponse<Local, Remote> value,
          $Res Function(CombinedLocalRemoteResponse<Local, Remote>) then) =
      _$CombinedLocalRemoteResponseCopyWithImpl<Local, Remote, $Res,
          CombinedLocalRemoteResponse<Local, Remote>>;
  @useResult
  $Res call({Remote remote, Local local});
}

/// @nodoc
class _$CombinedLocalRemoteResponseCopyWithImpl<Local, Remote, $Res,
        $Val extends CombinedLocalRemoteResponse<Local, Remote>>
    implements $CombinedLocalRemoteResponseCopyWith<Local, Remote, $Res> {
  _$CombinedLocalRemoteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = freezed,
    Object? local = freezed,
  }) {
    return _then(_value.copyWith(
      remote: freezed == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as Remote,
      local: freezed == local
          ? _value.local
          : local // ignore: cast_nullable_to_non_nullable
              as Local,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CombinedLocalRemoteResponseCopyWith<Local, Remote, $Res>
    implements $CombinedLocalRemoteResponseCopyWith<Local, Remote, $Res> {
  factory _$$_CombinedLocalRemoteResponseCopyWith(
          _$_CombinedLocalRemoteResponse<Local, Remote> value,
          $Res Function(_$_CombinedLocalRemoteResponse<Local, Remote>) then) =
      __$$_CombinedLocalRemoteResponseCopyWithImpl<Local, Remote, $Res>;
  @override
  @useResult
  $Res call({Remote remote, Local local});
}

/// @nodoc
class __$$_CombinedLocalRemoteResponseCopyWithImpl<Local, Remote, $Res>
    extends _$CombinedLocalRemoteResponseCopyWithImpl<Local, Remote, $Res,
        _$_CombinedLocalRemoteResponse<Local, Remote>>
    implements _$$_CombinedLocalRemoteResponseCopyWith<Local, Remote, $Res> {
  __$$_CombinedLocalRemoteResponseCopyWithImpl(
      _$_CombinedLocalRemoteResponse<Local, Remote> _value,
      $Res Function(_$_CombinedLocalRemoteResponse<Local, Remote>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remote = freezed,
    Object? local = freezed,
  }) {
    return _then(_$_CombinedLocalRemoteResponse<Local, Remote>(
      remote: freezed == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as Remote,
      local: freezed == local
          ? _value.local
          : local // ignore: cast_nullable_to_non_nullable
              as Local,
    ));
  }
}

/// @nodoc

class _$_CombinedLocalRemoteResponse<Local, Remote>
    implements _CombinedLocalRemoteResponse<Local, Remote> {
  const _$_CombinedLocalRemoteResponse(
      {required this.remote, required this.local});

  @override
  final Remote remote;
  @override
  final Local local;

  @override
  String toString() {
    return 'CombinedLocalRemoteResponse<$Local, $Remote>(remote: $remote, local: $local)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CombinedLocalRemoteResponse<Local, Remote> &&
            const DeepCollectionEquality().equals(other.remote, remote) &&
            const DeepCollectionEquality().equals(other.local, local));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(remote),
      const DeepCollectionEquality().hash(local));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CombinedLocalRemoteResponseCopyWith<Local, Remote,
          _$_CombinedLocalRemoteResponse<Local, Remote>>
      get copyWith => __$$_CombinedLocalRemoteResponseCopyWithImpl<
          Local,
          Remote,
          _$_CombinedLocalRemoteResponse<Local, Remote>>(this, _$identity);
}

abstract class _CombinedLocalRemoteResponse<Local, Remote>
    implements CombinedLocalRemoteResponse<Local, Remote> {
  const factory _CombinedLocalRemoteResponse(
          {required final Remote remote, required final Local local}) =
      _$_CombinedLocalRemoteResponse<Local, Remote>;

  @override
  Remote get remote;
  @override
  Local get local;
  @override
  @JsonKey(ignore: true)
  _$$_CombinedLocalRemoteResponseCopyWith<Local, Remote,
          _$_CombinedLocalRemoteResponse<Local, Remote>>
      get copyWith => throw _privateConstructorUsedError;
}
