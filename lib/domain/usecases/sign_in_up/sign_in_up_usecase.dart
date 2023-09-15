import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/utils/generate_device_id/generate_device_id.dart';

class SignInUpUseCase {
  final SignInUpRepository signInUpRepository;
  final GenerateDeviceId generateDeviceId;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final SharedPreferencesRepository _sharedPreferencesRepository;
  final UserLocalRepository _userLocalRepository;

  SignInUpUseCase({
    required this.signInUpRepository,
    required this.generateDeviceId,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required SharedPreferencesRepository sharedPreferencesRepository,
    required UserLocalRepository userLocalRepository,
  })  : _messageEncryptionUseCase = messageEncryptionUseCase,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _sharedPreferencesRepository = sharedPreferencesRepository,
        _userLocalRepository = userLocalRepository;

  Future<Either<Failure, User>> signUp(String phone, String password) async {
    // todo add validation maybe here as well
    try {
      final deviceId = await generateDeviceId.getDeviceId();
      final user = await signInUpRepository.signUp(deviceId, phone, password);
      final newKeyPair =
          await _messageEncryptionUseCase.generateNewE2EKeyPair();
      await _secretSharedPreferencesRepository.setE2EKeyPair(newKeyPair);
      await _userLocalRepository.setUser(user);
      await _sharedPreferencesRepository.setIsLogged(true);

      return right(user);
    } catch (e) {
      // TODO handle error
      return left(GeneralFailure(message: 'add error handling'));
    }
  }

  Future<Either<Failure, User>> login(String phone, String password) async {
    try {
      final deviceId = await generateDeviceId.getDeviceId();
      final user = await signInUpRepository.singIn(deviceId, phone, password);

      await _userLocalRepository.setUser(user);
      await _sharedPreferencesRepository.setIsLogged(true);

      return right(user);
    } catch (e) {
      // TODO handle error
      return left(GeneralFailure(message: 'add error handling'));
    }
  }
}
