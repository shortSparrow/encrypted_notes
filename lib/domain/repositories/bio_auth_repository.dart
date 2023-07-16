import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class BioAuthRepository {
  Future<bool> isWebBiometricSupported();
  Future<Either<Failure, List<int>>> registerWebBio(
    String randomStringFromServer,
    List<int> userIdArray,
    String userName,
  );
  Future<Either<Failure, bool>> loginWebBio(
    String randomStringFromServer,
    dynamic rawId,
  );
}
