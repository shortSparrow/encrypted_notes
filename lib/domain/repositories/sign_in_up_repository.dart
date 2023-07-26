import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/entities/user.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';

// TODO probably add special sightUpFailure
abstract class SignInUpRepository {
  Future<Either<Failure, User>> signUp(
    String deviceId,
    String phone,
    String password,
  );

  Future<Either<Failure, User>> singIn(
    String deviceId,
    String phone,
    String password,
  );
}
