import 'package:bloc/bloc.dart';
import 'package:encrypted_notes/domain/failures/biometrics_failures.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
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
        // TODO handle error, probably show toast
        if (failure is GeneralFailure) {
          print("ERROR: ${failure.message}");
        }
        if (failure is DeviceIsNotBrowser) {
          print("DeviceIsNotBrowser");
        }
        if (failure is BioNotSupported) {
          print("BioNotSupported");
        }
        if (failure is FailedCreateWebAuth) {
          print("FailedCreateWebAuth");
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
        if (failure is GeneralFailure) {
          print("${failure.message}");
        }
        if (failure is DeviceIsNotBrowser) {
          print("DeviceIsNotBrowser");
        }
        if (failure is NoSavedUserId) {
          print("NoSavedUserId");
        }
        if (failure is FailureAuthUsingBIO) {
          print("FailureAuthUsingBIO");
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
