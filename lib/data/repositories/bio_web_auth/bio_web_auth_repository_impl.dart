import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';

import '../../../domain/repositories/bio_auth_repository.dart';
import 'web_dummy.dart'
    if (dart.library.js) 'web_js.dart'; // <-For web

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
  Future<Either<Failure, bool>> loginWebBio(
    String randomStringFromServer,
    dynamic rawId,
  ) async {
    try {
      await js.loginBio(randomStringFromServer, rawId);
      return right(true);
    } catch (e) {
      JsFailure jsFailure = JsFailure.decodeFromJson(e as String);

      return left(GeneralFailure(message: jsFailure.message));
    }
  }

  @override
  Future<Either<Failure, List<int>>> registerWebBio(
    String randomStringFromServer,
    List<int> userIdArray,
    String userName,
  ) async {
    try {
      List<int> rawId =
          await js.registerBio(randomStringFromServer, userIdArray, userName);
      return right(rawId);
    } catch (e) {
      JsFailure jsFailure = JsFailure.decodeFromJson(e as String);
      if (jsFailure.reason == 'BIO_NOT_SUPPORTED' ||
          jsFailure.reason == 'FAILED_CREATE_WEBAUTH') {
        return left(GeneralFailure(message: jsFailure.message));
      }

      return left(GeneralFailure(message: "unkown error"));
    }
  }
}
