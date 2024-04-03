import 'package:encrypted_notes/domain/models/validation_rules/validation_rules.dart';

final phoneValidationRules = [
  const ValidationRules(
    regexRule: r'^\+[1-9]{1}[0-9]{3,14}$',
    errorMessage: "Invalid phone",
  ),
];
