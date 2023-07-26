import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/entities/user.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';

// TODO implement requiest with Dio
class SignInUpRepositoryImpl extends SignInUpRepository {
  @override
  Future<Either<Failure, User>>singIn(
    String deviceId,
    String phone,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return right(User());
  }

  @override
  Future<Either<Failure, User>> signUp(
    String deviceId,
    String phone,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return right(User());
  }
}
