import 'package:bloc/bloc.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/usecases/biometrics/biometric_auth_usease.dart';
import 'package:equatable/equatable.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  BiometricAuthUseCase getAvailableBiometricsUseCase;

  LoginCubit({required this.getAvailableBiometricsUseCase})
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
      (error) {
        // TODO handle error, probably show toast
        if (error is GeneralFailure) {
          print("ERROR: ${error.message}");
        } else {
          print("ERROR: ${error}");
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
      (l) {
        if (l is GeneralFailure) {
          print("${l.message}");
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
