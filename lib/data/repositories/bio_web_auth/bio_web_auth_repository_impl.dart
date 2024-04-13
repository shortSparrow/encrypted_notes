import 'package:encrypted_notes/domain/failures/failures.dart';

import '../../../domain/repositories/bio_auth_repository.dart';
import 'web_dummy.dart' if (dart.library.js) 'web_js.dart'; // <-For web

enum LoginWebBioErrorCodes { authUsingBIO, unexpected }

enum RegisterWebBioErrorCodes {
  bioNotSupported,
  failedCreateWebAuth,
  unexpected
}

class BioWebAuthRepositoryImpl extends BioAuthRepository {
  final js = Js();
  @override
  Future<bool> isWebBiometricSupported() async {
    try {
      bool isLocalAuthenticatorResult = await js.isLocalAuthenticator();
      bool isAuthAvailable = js.isAvailable();

      return isLocalAuthenticatorResult && isAuthAvailable;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> loginWebBio(
    String randomStringFromServer,
    dynamic rawId,
  ) async {
    try {
      await js.loginBio(randomStringFromServer, rawId);
    } catch (e) {
      JsFailure jsFailure = JsFailure.decodeFromJson(e as String);
      if (jsFailure.reason == "FAILED_LOGIN") {
        throw AppError(
          code: LoginWebBioErrorCodes.authUsingBIO,
          message: jsFailure.message,
        );
      }

      throw AppError(
        code: LoginWebBioErrorCodes.unexpected,
        message: jsFailure.message,
      );
    }
  }

  @override
  Future<List<int>> registerWebBio(
    String randomStringFromServer,
    List<int> userIdArray,
    String userName,
  ) async {
    try {
      List<int> rawId =
          await js.registerBio(randomStringFromServer, userIdArray, userName);
      return rawId;
    } catch (e) {
      JsFailure jsFailure = JsFailure.decodeFromJson(e as String);
      if (jsFailure.reason == 'BIO_NOT_SUPPORTED') {
        // return left(AppError(code: RegisterWebBioErrorCodes.bioNotSupported));
        throw AppError(code: RegisterWebBioErrorCodes.bioNotSupported);
      }
      if (jsFailure.reason == 'FAILED_CREATE_WEBAUTH') {
        // return left(
        //     AppError(code: RegisterWebBioErrorCodes.failedCreateWebAuth));
        throw AppError(code: RegisterWebBioErrorCodes.failedCreateWebAuth);
      }

      // return left(AppError(code: RegisterWebBioErrorCodes.unexpected));
      throw AppError(code: RegisterWebBioErrorCodes.unexpected);
    }
  }

  @override
  Future<bool> loginBio() {
    // TODO: implement loginBio. Use library
    throw UnimplementedError();
  }
}
