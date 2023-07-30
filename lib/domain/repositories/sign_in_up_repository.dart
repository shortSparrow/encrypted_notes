import 'package:encrypted_notes/domain/models/user.dart';

// TODO probably add special sightUpFailure
abstract class SignInUpRepository {
  Future<User> signUp(
    String deviceId,
    String phone,
    String password,
  );

  Future<User> singIn(
    String deviceId,
    String phone,
    String password,
  );

// TODO add logout
  // Future<Either<Failure, bool>> logout();
}
