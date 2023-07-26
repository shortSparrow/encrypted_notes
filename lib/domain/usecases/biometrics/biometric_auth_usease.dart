import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/failures/biometrics_failures.dart';
import 'package:encrypted_notes/extensions/Either.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../failures/failures.dart';
import '../../repositories/bio_auth_repository.dart';

class BiometricAuthUseCase {
  final BioAuthRepository bioAuthRepository;
  BiometricAuthUseCase({
    required this.bioAuthRepository,
  });

  List<dynamic>? userRawId;

// todo nor it is just mock data, do it in real
  dynamic getUserRawId() {
    return userRawId;
  }

  Future<Either<Failure, bool>> registerBioForWeb(
    String userName,
  ) async {
    if (kIsWeb) {
      final userRawIdArray = await bioAuthRepository.registerWebBio(
        "randomStringFromServer",
        [1, 2, 3, 4],
        userName,
      );

      if (userRawIdArray.isRight()) {
        // TODO save rawId

        return right(true);
      }

      return left(userRawIdArray.asLeft());
    }
    return left(DeviceIsNotBrowser());
  }

  Future<Either<Failure, bool>> loginBioForWeb() async {
    if (kIsWeb) {
      final userRawId = getUserRawId();
      if (userRawId == null) {
        return left(NoSavedUserId());
      }
      final loginResult = await bioAuthRepository.loginWebBio(
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
        isDeviceSupported = await bioAuthRepository.isWebBiometricSupported();
      }

      // if (Platform.isAndroid || Platform.isIOS || Platform.isWindows) {} // TODO
    } catch (e) {
      left(GeneralFailure(message: "Unknown Error"));
    }
    return right(isDeviceSupported);
  }
}
