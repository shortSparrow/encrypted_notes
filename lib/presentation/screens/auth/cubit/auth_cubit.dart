import 'package:bloc/bloc.dart';
import 'package:encrypted_notes/domain/usecases/biometrics/biometric_auth_usease.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  BiometricAuthUseCase getAvailableBiometricsUseCase;

  AuthCubit({required this.getAvailableBiometricsUseCase})
      : super(LoginInitial());

  void checkIfBiometricsAvailable() async {
    final response = await getAvailableBiometricsUseCase.isBiometricSupported();

    response.fold(
      (error) => null,
      (isSuccess) {
        if (isSuccess) {
          emit(LoginHasBiometricAbility());
        }
      },
    );
  }

  Future<bool> registerBioForWeb() async {
    final didAuthenticate =
        await getAvailableBiometricsUseCase.registerBioForWeb('sasha');

    return didAuthenticate.fold(
      (failure) {
        switch (failure.code) {
          case RegisterBioForWebError.bioNotSupported:
          case RegisterBioForWebError.failedCreateWebAuth:
          case RegisterBioForWebError.unexpected:
          case RegisterBioForWebError.deviceIsNotBrowser:
            print("registerBioForWeb error: ${failure.message}");
        }

        return false;
      },
      (rawIdArray) {
        print("REGISTER SUCCESS");
        return true;
      },
    );
  }

  void callBiometricAuth() async {
    final loginResult = await getAvailableBiometricsUseCase.loginBioForWeb();
    loginResult.fold(
      (failure) {
        switch (failure.code) {
          case LoginBioForWebError.webBioIdNoteSaved:
          case LoginBioForWebError.deviceIsNotBrowser:
          case LoginBioForWebError.unexpected:
          case LoginBioForWebError.authUsingBIO:
            print("callBiometricAuth error: ${failure.message}");
        }

        print("FAILED LOGIN");
      },
      (r) {
        print("LOGIN SUCCESS");
      },
    );
  }

  void onPressLogin() {
    // TODO
  }
}
