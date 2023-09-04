import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';

// TODO implement requiest with Dio
class SignInUpRepositoryImpl extends SignInUpRepository {
  @override
  Future<User>singIn(
    String deviceId,
    String phone,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return User();
  }

  @override
  Future<User> signUp(
    String deviceId,
    String phone,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return User();
  }
}
