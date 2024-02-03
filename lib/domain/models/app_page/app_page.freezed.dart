// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppPage {
  String get name => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppPageCopyWith<AppPage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPageCopyWith<$Res> {
  factory $AppPageCopyWith(AppPage value, $Res Function(AppPage) then) =
      _$AppPageCopyWithImpl<$Res, AppPage>;
  @useResult
  $Res call({String name, String route, String path});
}

/// @nodoc
class _$AppPageCopyWithImpl<$Res, $Val extends AppPage>
    implements $AppPageCopyWith<$Res> {
  _$AppPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? route = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppPageImplCopyWith<$Res> implements $AppPageCopyWith<$Res> {
  factory _$$AppPageImplCopyWith(
          _$AppPageImpl value, $Res Function(_$AppPageImpl) then) =
      __$$AppPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String route, String path});
}

/// @nodoc
class __$$AppPageImplCopyWithImpl<$Res>
    extends _$AppPageCopyWithImpl<$Res, _$AppPageImpl>
    implements _$$AppPageImplCopyWith<$Res> {
  __$$AppPageImplCopyWithImpl(
      _$AppPageImpl _value, $Res Function(_$AppPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? route = null,
    Object? path = null,
  }) {
    return _then(_$AppPageImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppPageImpl implements _AppPage {
  const _$AppPageImpl(
      {required this.name, required this.route, required this.path});

  @override
  final String name;
  @override
  final String route;
  @override
  final String path;

  @override
  String toString() {
    return 'AppPage(name: $name, route: $route, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppPageImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, route, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppPageImplCopyWith<_$AppPageImpl> get copyWith =>
      __$$AppPageImplCopyWithImpl<_$AppPageImpl>(this, _$identity);
}

abstract class _AppPage implements AppPage {
  const factory _AppPage(
      {required final String name,
      required final String route,
      required final String path}) = _$AppPageImpl;

  @override
  String get name;
  @override
  String get route;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$AppPageImplCopyWith<_$AppPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
