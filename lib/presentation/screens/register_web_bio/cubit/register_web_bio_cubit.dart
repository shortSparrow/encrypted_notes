import 'package:bloc/bloc.dart';
import 'package:encrypted_notes/domain/usecases/biometrics/biometric_auth_usease.dart';
import 'package:equatable/equatable.dart';

part 'register_web_bio_state.dart';

class RegisterWebBioCubit extends Cubit<RegisterWebBioState> {
  BiometricAuthUseCase getAvailableBiometricsUseCase;

  RegisterWebBioCubit({required this.getAvailableBiometricsUseCase})
      : super(RegisterWebBioInitial());

  void checkIfBiometricsAvailable() async {
    final response = await getAvailableBiometricsUseCase.isBiometricSupported();

    response.fold(
      (error) {
        emit(RegisterWebBioNotAvailable());
      },
      (isSuccess) {
        if (isSuccess) {
          emit(RegisterWebBioAvailable());
        } else {
          emit(RegisterWebBioNotAvailable());
        }
      },
    );
  }
}
