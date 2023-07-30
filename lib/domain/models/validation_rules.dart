
import 'package:equatable/equatable.dart';

class ValidationRules extends Equatable {
  const ValidationRules({required this.regexRule, required this.errorMessage});

  final String regexRule;
  final String errorMessage;

  @override
  List<Object?> get props => [regexRule, errorMessage];
}

