import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';
import 'package:encrypted_notes/presentation/core/models/edit_text.dart';
import 'package:encrypted_notes/presentation/core/models/text_filed_validator.dart';
import 'package:encrypted_notes/utils/validation/sign_in_up/password_validation.dart';
import 'package:encrypted_notes/utils/validation/sign_in_up/phone_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.signInUpUseCase}) : super(const SignUpState()) {
    on<OnPasswordChange>(_onPasswordChanged);
    on<OnPhoneChange>(_onPhoneChanged);
    on<OnRegister>(_register);
  }

  final SignInUpUseCase signInUpUseCase;

  Future _register(OnRegister event, Emitter<SignUpState> emit) async {
    final passwordValidation = _validatePassword(state.password.value);
    final phoneValidation = _validatePhone(state.phone.value);
    emit(
      state.copyWith(
        password: state.password.copyWith(
          isRuntimeValidationEnable: true,
          validation: passwordValidation,
        ),
        phone: state.phone.copyWith(
          isRuntimeValidationEnable: true,
          validation: phoneValidation,
        ),
      ),
    );

    if (!passwordValidation.isValid || !phoneValidation.isValid) {
      return;
    }

    emit(
      state.copyWith(
        signUpStatus: RequestStatus.loading,
      ),
    );

    final result =
        await signInUpUseCase.signUp(state.phone.value, state.password.value);

    result.fold(
      (failure) {
        emit(state.copyWith(
          signUpStatus: RequestStatus.failed,
          signUpError: failure.message,
        ));
      },
      (user) {
        emit(state.copyWith(
          signUpError: null,
          signUpStatus: RequestStatus.success,
        ));
      },
    );
  }

  void _onPasswordChanged(OnPasswordChange event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        signUpStatus: RequestStatus.idle,
        password: state.password.copyWith(
          value: event.value,
          validation: state.password.isRuntimeValidationEnable
              ? _validatePassword(event.value)
              : state.password.validation,
        ),
      ),
    );
  }

  void _onPhoneChanged(OnPhoneChange event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        signUpStatus: RequestStatus.idle,
        phone: state.password.copyWith(
          value: event.value,
          validation: state.phone.isRuntimeValidationEnable
              ? _validatePhone(event.value)
              : null,
        ),
      ),
    );
  }

  TextFieldValidator _validatePhone(String value) {
    final possibleError = phoneValidationRules
        .where((rule) => !RegExp(rule.regexRule).hasMatch(value))
        .firstOrNull;

    final isValid = possibleError == null;
    return TextFieldValidator(isValid, possibleError?.errorMessage);
  }

  TextFieldValidator _validatePassword(String value) {
    final possibleError = passwordValidationRules
        .where((rule) => !RegExp(rule.regexRule).hasMatch(value))
        .firstOrNull;

    final isValid = possibleError == null;
    return TextFieldValidator(isValid, possibleError?.errorMessage);
  }
}
