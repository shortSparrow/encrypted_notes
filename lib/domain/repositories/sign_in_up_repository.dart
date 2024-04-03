import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';

class RegisterUserResponse {
  final User user;
  final UserTokens tokens;

  RegisterUserResponse({
    required this.user,
    required this.tokens,
  });
}

class LoginUserResponse {
  final User user;
  final UserTokens tokens;

  LoginUserResponse({
    required this.user,
    required this.tokens,
  });
}

abstract class SignInUpRepository {
  Future<RegisterUserResponse> signUp({
    required String deviceId,
    required String phone,
    required String password,
    required SimplePublicKey noteEncryptionPublicKey,
  });

  Future<LoginUserResponse> singIn({
    required String deviceId,
    required String phone,
    required String password,
    required SimplePublicKey noteEncryptionPublicKey,
  });

// TODO add logout
// Future<Either<Failure, bool>> logout();
}
