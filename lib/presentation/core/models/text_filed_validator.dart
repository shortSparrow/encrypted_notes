import 'package:equatable/equatable.dart';

class TextFieldValidator extends Equatable {
  const TextFieldValidator(this.isValid, this.errorMessage);
  final bool isValid;
  final String? errorMessage;

  const TextFieldValidator.valid({
    this.isValid = true,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [isValid, errorMessage];
}
