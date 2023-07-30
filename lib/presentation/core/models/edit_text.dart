import 'package:encrypted_notes/presentation/core/models/text_filed_validator.dart';
import 'package:equatable/equatable.dart';

class EditText extends Equatable {
  const EditText({
    this.value = "",
    this.validation = const TextFieldValidator.valid(),
    this.isRuntimeValidationEnable = false,
  });

  final String value;
  final TextFieldValidator validation;
  final bool isRuntimeValidationEnable;

  EditText copyWith({
    String? value,
    TextFieldValidator? validation,
    bool? isRuntimeValidationEnable,
  }) {
    return EditText(
      value: value ?? this.value,
      validation: validation ?? this.validation,
      isRuntimeValidationEnable:
          isRuntimeValidationEnable ?? this.isRuntimeValidationEnable,
    );
  }

  @override
  List<Object?> get props => [value, validation, isRuntimeValidationEnable];
}
