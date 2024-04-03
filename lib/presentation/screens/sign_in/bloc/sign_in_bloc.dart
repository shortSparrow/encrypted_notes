import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';
import 'package:encrypted_notes/presentation/core/models/edit_text.dart';
import 'package:encrypted_notes/presentation/core/models/text_filed_validator.dart';
import 'package:encrypted_notes/utils/validation/sign_in_up/password_validation.dart';
import 'package:encrypted_notes/utils/validation/sign_in_up/phone_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.signInUpUseCase}) : super(const SignInState()) {
    on<OnPasswordChange>(_onPasswordChanged);
    on<OnPhoneChange>(_onPhoneChanged);
    on<OnLogin>(_login);
  }

  final SignInUpUseCase signInUpUseCase;

  Future _login(OnLogin event, Emitter<SignInState> emit) async {
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
        signInStatus: RequestStatus.loading,
      ),
    );

    final result =
        await signInUpUseCase.login(state.phone.value, state.password.value);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            signInStatus: RequestStatus.failed,
            signUpError: failure.message,
          ),
        );
      },
      (user) {
        emit(state.copyWith(
            signUpError: null, signInStatus: RequestStatus.success));
      },
    );
  }

  void _onPasswordChanged(OnPasswordChange event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        signInStatus: RequestStatus.idle,
        password: state.password.copyWith(
          value: event.value,
          validation: state.password.isRuntimeValidationEnable
              ? _validatePassword(event.value)
              : state.password.validation,
        ),
      ),
    );
  }

  void _onPhoneChanged(OnPhoneChange event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        signInStatus: RequestStatus.idle,
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
