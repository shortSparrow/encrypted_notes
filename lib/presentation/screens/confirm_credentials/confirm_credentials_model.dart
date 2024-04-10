import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';
import 'package:encrypted_notes/main.dart';
import 'package:encrypted_notes/presentation/core/models/text_filed_validator.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/utils/validation/sign_in_up/password_validation.dart';
import 'package:encrypted_notes/utils/validation/sign_in_up/phone_validation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UiState {
  bool isLoadingLogin = false;
  bool isLoginButtonDisable = false;
  String? phoneErrorMessage;
  String? passwordErrorMessage;

  _setIsLoginButtonDisable() {
    if (phoneErrorMessage == null &&
        passwordErrorMessage == null &&
        isLoadingLogin == false) {
      isLoginButtonDisable = false;
    } else {
      isLoginButtonDisable = true;
    }
  }
}

class State {
  bool isRuntimeValidationPhoneEnable = false;
  bool isRuntimeValidationPasswordEnable = false;
}

class ConfirmCredentialsModel extends ChangeNotifier {
  SignInUpUseCase _signInUpUseCase;

  ConfirmCredentialsModel({required SignInUpUseCase signInUpUseCase})
      : _signInUpUseCase = signInUpUseCase;

  var _phoneValue = '';
  var _passwordValue = '';

  UiState uiState = UiState();
  final State _state = State();

  login() async {
    final passwordValidation = _validatePassword(_passwordValue);
    final phoneValidation = _validatePhone(_phoneValue);

    if (!passwordValidation.isValid || !phoneValidation.isValid) {
      uiState.passwordErrorMessage = passwordValidation.errorMessage;
      uiState.phoneErrorMessage = phoneValidation.errorMessage;
      uiState._setIsLoginButtonDisable();

      _state.isRuntimeValidationPasswordEnable = true;
      _state.isRuntimeValidationPhoneEnable = true;
      notifyListeners();
      return;
    }
    uiState.isLoadingLogin = true;
    notifyListeners();

    final response = await _signInUpUseCase.reloginForGetNewTokens(
        _phoneValue, _passwordValue);
    response.fold(
      (error) {
        print("FAIL CONGIRM CREDS: ${error}");
      },
      (user) {
        print("SUCCESS CONGIRM CREDS");
        MyApp.ctx?.go(AppScreens.home.path);
      },
    );
    uiState.isLoadingLogin = false;
    notifyListeners();
  }

  Future<void> logout() async {
    // TODO
  }

  void onPasswordChanged(String value) {
    _passwordValue = value;
    if (_state.isRuntimeValidationPasswordEnable) {
      uiState.passwordErrorMessage = _validatePassword(value).errorMessage;
      uiState._setIsLoginButtonDisable();
      notifyListeners();
    }
  }

  void onPhoneChanged(String value) {
    _phoneValue = value;
    if (_state.isRuntimeValidationPhoneEnable) {
      uiState.phoneErrorMessage = _validatePhone(value).errorMessage;
      uiState._setIsLoginButtonDisable();
      notifyListeners();
    }
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
