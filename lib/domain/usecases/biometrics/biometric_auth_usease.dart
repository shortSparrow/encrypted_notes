import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/data/repositories/bio_web_auth/bio_web_auth_repository_impl.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../failures/failures.dart';
import '../../repositories/bio_auth_repository.dart';

enum RegisterBioForWebError {
  bioNotSupported,
  failedCreateWebAuth,
  unexpected,
  deviceIsNotBrowser
}

enum LoginBioForWebError {
  webBioIdNoteSaved,
  deviceIsNotBrowser,
  unexpected,
  authUsingBIO,
}

class BiometricAuthUseCase {
  final BioAuthRepository _bioAuthRepository;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;

  BiometricAuthUseCase({
    required BioAuthRepository bioAuthRepository,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required AppStateSharedPreferencesRepository sharedPreferencesRepository,
  })  : _bioAuthRepository = bioAuthRepository,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository;

  List<dynamic>? userRawId;

  Future<Either<AppError<RegisterBioForWebError>, Unit>> registerBioForWeb(
    String userName,
  ) async {
    try {
      if (kIsWeb) {
        final userRawIdArray = await _bioAuthRepository.registerWebBio(
          "randomStringFromServer",
          [1, 2, 3, 4],
          userName,
        );

        await _secretSharedPreferencesRepository.setWebBioId(userRawIdArray);

        return right(unit);
      } else {
        return left(AppError(code: RegisterBioForWebError.deviceIsNotBrowser));
      }
    } on AppError<RegisterWebBioErrorCodes> catch (err) {
      switch (err.code) {
        case RegisterWebBioErrorCodes.bioNotSupported:
          return left(AppError(code: RegisterBioForWebError.bioNotSupported));
        case RegisterWebBioErrorCodes.failedCreateWebAuth:
          return left(
              AppError(code: RegisterBioForWebError.failedCreateWebAuth));
        case RegisterWebBioErrorCodes.unexpected:
          return left(AppError(code: RegisterBioForWebError.unexpected));
      }
    } catch (err) {
      return left(AppError(code: RegisterBioForWebError.unexpected));
    }
  }

  Future<Either<AppError<LoginBioForWebError>, Unit>> loginBioForWeb() async {
    try {
      if (kIsWeb) {
        final userRawId =
            await _secretSharedPreferencesRepository.getWebBioId();
        if (userRawId == null) {
          return left(AppError(code: LoginBioForWebError.webBioIdNoteSaved));
        }
        await _bioAuthRepository.loginWebBio(
          "randomStringFromServer",
          userRawId,
        );

        right(unit);
      }
      return left(AppError(code: LoginBioForWebError.deviceIsNotBrowser));
    } on AppError<LoginWebBioErrorCodes> catch (err) {
      switch (err.code) {
        case LoginWebBioErrorCodes.authUsingBIO:
          return left(AppError(
              code: LoginBioForWebError.authUsingBIO, message: err.message));
        case LoginWebBioErrorCodes.unexpected:
          return left(AppError(code: LoginBioForWebError.unexpected));
      }
    } catch (err) {
      return left(AppError(code: LoginBioForWebError.unexpected));
    }
  }

  Future<Either<UnexpectedError, bool>> isBiometricSupported() async {
    bool isDeviceSupported = false;

    try {
      if (kIsWeb) {
        isDeviceSupported = await _bioAuthRepository.isWebBiometricSupported();
      }

      // if (Platform.isAndroid || Platform.isIOS || Platform.isWindows) {} // TODO
    } catch (e) {
      left(UnexpectedError(message: e.toString()));
    }
    return right(isDeviceSupported);
  }
}
