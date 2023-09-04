// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ValidationRules {
  String get regexRule => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidationRulesCopyWith<ValidationRules> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationRulesCopyWith<$Res> {
  factory $ValidationRulesCopyWith(
          ValidationRules value, $Res Function(ValidationRules) then) =
      _$ValidationRulesCopyWithImpl<$Res, ValidationRules>;
  @useResult
  $Res call({String regexRule, String errorMessage});
}

/// @nodoc
class _$ValidationRulesCopyWithImpl<$Res, $Val extends ValidationRules>
    implements $ValidationRulesCopyWith<$Res> {
  _$ValidationRulesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regexRule = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      regexRule: null == regexRule
          ? _value.regexRule
          : regexRule // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ValidationRulesCopyWith<$Res>
    implements $ValidationRulesCopyWith<$Res> {
  factory _$$_ValidationRulesCopyWith(
          _$_ValidationRules value, $Res Function(_$_ValidationRules) then) =
      __$$_ValidationRulesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String regexRule, String errorMessage});
}

/// @nodoc
class __$$_ValidationRulesCopyWithImpl<$Res>
    extends _$ValidationRulesCopyWithImpl<$Res, _$_ValidationRules>
    implements _$$_ValidationRulesCopyWith<$Res> {
  __$$_ValidationRulesCopyWithImpl(
      _$_ValidationRules _value, $Res Function(_$_ValidationRules) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regexRule = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_ValidationRules(
      regexRule: null == regexRule
          ? _value.regexRule
          : regexRule // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ValidationRules implements _ValidationRules {
  const _$_ValidationRules(
      {required this.regexRule, required this.errorMessage});

  @override
  final String regexRule;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'ValidationRules(regexRule: $regexRule, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ValidationRules &&
            (identical(other.regexRule, regexRule) ||
                other.regexRule == regexRule) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, regexRule, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ValidationRulesCopyWith<_$_ValidationRules> get copyWith =>
      __$$_ValidationRulesCopyWithImpl<_$_ValidationRules>(this, _$identity);
}

abstract class _ValidationRules implements ValidationRules {
  const factory _ValidationRules(
      {required final String regexRule,
      required final String errorMessage}) = _$_ValidationRules;

  @override
  String get regexRule;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_ValidationRulesCopyWith<_$_ValidationRules> get copyWith =>
      throw _privateConstructorUsedError;
}
