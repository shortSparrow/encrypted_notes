import 'package:dartz/dartz.dart';
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

  Future<Either<Failure, List<int>>> registerBioForWeb(
    String userName,
  ) async {
    if (kIsWeb) {
      final userRawIdArray = await bioAuthRepository.registerWebBio(
        "randomStringFromServer",
        [1, 2, 3, 4],
        userName,
      );

      return userRawIdArray;
    }
    return left(GeneralFailure(message: "device is not a web browser"));
  }

  Future<Either<Failure, bool>> loginBioForWeb() async {
    if (kIsWeb) {
      final userRawId = getUserRawId();
      if(userRawId == null) {
        return left(GeneralFailure(message: "there is no user id"));
      }
      final loginResult = await bioAuthRepository.loginWebBio(
        "randomStringFromServer",
        userRawId,
      );

      return loginResult;
    }
    return left(GeneralFailure(message: "device is not a web browser"));
  }

  Future<Either<Failure, bool>> isBiometricSupported() async {
    bool isDeviceSupported = false;

    try {
      // if (Platform.isAndroid || Platform.isIOS || Platform.isWindows) {} // FIXME return error on web

      if (kIsWeb) {
        isDeviceSupported = await bioAuthRepository.isWebBiometricSupported();
      }
    } catch (e) {
      left(GeneralFailure(message: "Unknown Error"));
    }
    return right(isDeviceSupported);
  }
}
