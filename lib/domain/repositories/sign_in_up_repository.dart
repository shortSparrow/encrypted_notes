import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/login/login.dart';
import 'package:encrypted_notes/domain/models/register/register.dart';

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

  Future logout();
}
