import 'package:encrypted_notes/domain/models/validation_rules/validation_rules.dart';

final phoneValidationRules = [
  const ValidationRules(
    regexRule: r"^\+?\d{1,4}[-\s]?\d{1,4}[-\s]?\d{1,4}[-\s]?\d{1,6}$",
    errorMessage: "Invalid phone",
  ),
];
