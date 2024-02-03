import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/failures/biometrics_failures.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/extensions/Either.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../failures/failures.dart';
import '../../repositories/bio_auth_repository.dart';

class BiometricAuthUseCase {
  final BioAuthRepository _bioAuthRepository;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;

  BiometricAuthUseCase({
    required BioAuthRepository bioAuthRepository,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required SharedPreferencesRepository sharedPreferencesRepository,
  })  : _bioAuthRepository = bioAuthRepository,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository;

  List<dynamic>? userRawId;

  Future<Either<Failure, bool>> registerBioForWeb(
    String userName,
  ) async {
    if (kIsWeb) {
      final userRawIdArray = await _bioAuthRepository.registerWebBio(
        "randomStringFromServer",
        [1, 2, 3, 4],
        userName,
      );

      if (userRawIdArray.isRight()) {
        await _secretSharedPreferencesRepository
            .setWebBioId(userRawIdArray.asRight());

        return right(true);
      }

      return left(userRawIdArray.asLeft());
    }
    return left(DeviceIsNotBrowser());
  }

  Future<Either<Failure, bool>> loginBioForWeb() async {
    if (kIsWeb) {
      final userRawId = await _secretSharedPreferencesRepository.getWebBioId();
      if (userRawId == null) {
        return left(NoSavedUserId());
      }
      final loginResult = await _bioAuthRepository.loginWebBio(
        "randomStringFromServer",
        userRawId,
      );

      loginResult.fold(
        (failure) {},
        (isSuccess) {
          if (isSuccess) {
            // TODO ADD global key that user authorized
          }
        },
      );

      return loginResult;
    }
    return left(DeviceIsNotBrowser());
  }

  Future<Either<Failure, bool>> isBiometricSupported() async {
    bool isDeviceSupported = false;

    try {
      if (kIsWeb) {
        isDeviceSupported = await _bioAuthRepository.isWebBiometricSupported();
      }

      // if (Platform.isAndroid || Platform.isIOS || Platform.isWindows) {} // TODO
    } catch (e) {
      left(GeneralFailure(message: "Unknown Error"));
    }
    return right(isDeviceSupported);
  }
}
