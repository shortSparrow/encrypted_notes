import 'package:cryptography/cryptography.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/extensions/encryption_key_extension.dart';
import 'package:encrypted_notes/utils/generate_device_id/generate_device_id.dart';

class SignInUpUseCase {
  final SignInUpRepository signInUpRepository;
  final GenerateDeviceId generateDeviceId;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final SharedPreferencesRepository _sharedPreferencesRepository;
  final UserLocalRepository _userLocalRepository;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;

  SignInUpUseCase({
    required this.signInUpRepository,
    required this.generateDeviceId,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required SharedPreferencesRepository sharedPreferencesRepository,
    required UserLocalRepository userLocalRepository,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
  })  : _messageEncryptionUseCase = messageEncryptionUseCase,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _sharedPreferencesRepository = sharedPreferencesRepository,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal,
        _userLocalRepository = userLocalRepository;

  Future<Either<GeneralFailure, User>> signUp(
    String phone,
    String password,
  ) async {
    // todo add validation maybe here as well
    try {
      final deviceId = await generateDeviceId.generateUniqueDeviceId();
      final newKeyPair =
          await _messageEncryptionUseCase.generateNewE2EKeyPair();
      final newKeyPairData = await newKeyPair.extract();

      final registerResponse = await signInUpRepository.signUp(
        deviceId: deviceId,
        phone: phone,
        password: password,
        noteEncryptionPublicKey: newKeyPairData.publicKey,
      );

      await _setupUserData(
        deviceId: deviceId,
        devicePublicKey: newKeyPairData.publicKey.toJsonString(),
        user: registerResponse.user,
        tokens: registerResponse.tokens,
        newKeyPair: newKeyPair,
      );

      return right(registerResponse.user);
    } on NetworkFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(
          GeneralFailure(message: "can't register user, unknown error happen"));
    }
  }


  Future<Either<GeneralFailure, User>> login(
    String phone,
    String password,
  ) async {
    try {
      final deviceId = await generateDeviceId.generateUniqueDeviceId();
      final newKeyPair =
          await _messageEncryptionUseCase.generateNewE2EKeyPair();
      final newKeyPairData = await newKeyPair.extract();

      final loginResult = await signInUpRepository.singIn(
        deviceId: deviceId,
        phone: phone,
        password: password,
        noteEncryptionPublicKey: newKeyPairData.publicKey,
      );

      await _setupUserData(
        deviceId: deviceId,
        devicePublicKey: newKeyPairData.publicKey.toJsonString(),
        user: loginResult.user,
        tokens: loginResult.tokens,
        newKeyPair: newKeyPair,
      );

      return right(loginResult.user);
    } on NetworkFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(
          GeneralFailure(message: "can't login user, unknown error happen"));
    }
  }

  Future _setupUserData({
    required String deviceId,
    required String devicePublicKey,
    required User user,
    required UserTokens tokens,
    required SimpleKeyPair newKeyPair,
  }) async {
    await _remoteDeviceRepositoryLocal.addRemoteDevice(
      RemoteDevicesCompanion(
        id: Value(deviceId),
        devicePublicKey: Value(devicePublicKey),
        deviceName: Value.absent(), // TODO add devicename,
        systemVersion: Value.absent(), // TODO add systemVersion 
        userId: Value(user.id),
      ),
    );

    await _userLocalRepository.setUser(user);
    await _userLocalRepository.setUserTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await _secretSharedPreferencesRepository.setE2EKeyPair(newKeyPair);
    final localKey =
        await _messageEncryptionUseCase.generateNewLocalSymmetricKey();
    await _secretSharedPreferencesRepository.setLocalSymmetricKey(localKey);

    await _sharedPreferencesRepository.setIsLogged(true);
    setHTTPAccessToken();
  }
}
