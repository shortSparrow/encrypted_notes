import 'package:encrypted_notes/domain/models/validation_rules.dart';

final passwordValidationRules = [
  const ValidationRules(
    regexRule: r'^.{8,}$',
    errorMessage: "Password must contain at least 8 characters",
  ),
  const ValidationRules(
    regexRule: r'^(?=.*[A-Z]).+$',
    errorMessage: "Password must contain characters in upper case",
  ),
  const ValidationRules(
    regexRule: r'^(?=.*[a-z]).+$',
    errorMessage: "Password must contain character in lower case",
  ),
  const ValidationRules(
    regexRule: r'^(?=.*\d).+$',
    errorMessage: "Password must contain digit",
  ),
];