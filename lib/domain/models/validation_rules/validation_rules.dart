import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_rules.freezed.dart';

@freezed
class ValidationRules with _$ValidationRules {
  const factory ValidationRules({
    required String regexRule,
    required String errorMessage,
  }) = _ValidationRules;
}
