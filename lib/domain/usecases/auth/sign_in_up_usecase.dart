import 'package:cryptography/cryptography.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/remote/token_service.dart';
import 'package:encrypted_notes/domain/failures/remote_repository_failures.dart';
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

enum RegisterErrorCodes { unexpected, network }
enum LoginErrorCodes { unexpected, network }
enum ReLoginErrorCodes { unexpected, deviceIdNull, network }

class SignInUpUseCase {
  final SignInUpRepository _signInUpRepository;
  final GenerateDeviceId _generateDeviceId;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final AppStateSharedPreferencesRepository _sharedPreferencesRepository;
  final UserLocalRepository _userLocalRepository;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;
  final TokenService _tokenService;

  SignInUpUseCase({
    required SignInUpRepository signInUpRepository,
    required GenerateDeviceId generateDeviceId,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required AppStateSharedPreferencesRepository sharedPreferencesRepository,
    required UserLocalRepository userLocalRepository,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
    required TokenService tokenService,
  })  : _signInUpRepository = signInUpRepository,
        _generateDeviceId = generateDeviceId,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _sharedPreferencesRepository = sharedPreferencesRepository,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal,
        _userLocalRepository = userLocalRepository,
        _tokenService = tokenService;

  Future<Either<AppError<RegisterErrorCodes>, User>> register(
    String phone,
    String password,
  ) async {
    // todo add validation maybe here as well
    try {
      final deviceId = await _generateDeviceId.generateUniqueDeviceId();
      final newKeyPair =
          await _messageEncryptionUseCase.generateNewE2EKeyPair();
      final newKeyPairData = await newKeyPair.extract();

      final registerResponse = await _signInUpRepository.signUp(
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
    } on NetworkError catch (e) {
      return left(
          AppError(code: RegisterErrorCodes.network, message: e.message));
    } catch (e) {
      return left(
          AppError(code: RegisterErrorCodes.unexpected, message: e.toString()));
    }
  }

  Future<Either<AppError<LoginErrorCodes>, User>> loginFromCleanDevice(
    String phone,
    String password,
  ) async {
    try {
      final oldDeviceId = _userLocalRepository.getUser()?.deviceId;
      final deviceId =
          oldDeviceId ?? await _generateDeviceId.generateUniqueDeviceId();

      final newKeyPair =
          await _messageEncryptionUseCase.generateNewE2EKeyPair();
      final newKeyPairData = await newKeyPair.extract();

      final loginResult = await _signInUpRepository.singIn(
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
    } on RemoteRepositoryError catch (e) {
      return left(AppError(code: LoginErrorCodes.network, message: e.message));
    } catch (e) {
      return left(
          AppError(code: LoginErrorCodes.unexpected, message: e.toString()));
    }
  }

  Future<Either<AppError<ReLoginErrorCodes>, User>> reloginForGetNewTokens(
    String phone,
    String password,
  ) async {
    try {
      final oldDeviceId = _userLocalRepository.getUser()?.deviceId;
      if (oldDeviceId == null) {
        return left(AppError(
            message: "deviceId is null", code: ReLoginErrorCodes.deviceIdNull));
      }

      final e2eKeyPair =
          await _secretSharedPreferencesRepository.getE2EKeyPair();
      final keyPairData = await e2eKeyPair.extract();

      final loginResult = await _signInUpRepository.singIn(
        deviceId: oldDeviceId,
        phone: phone,
        password: password,
        noteEncryptionPublicKey: keyPairData.publicKey,
      );

      await _tokenService.setUserTokens(
        accessToken: loginResult.tokens.accessToken,
        refreshToken: loginResult.tokens.refreshToken,
      );

      await _sharedPreferencesRepository.setIsLogged(true);

      return right(loginResult.user);
    } on RemoteRepositoryError catch (err) {
      return left(
          AppError(message: err.message, code: ReLoginErrorCodes.network));
    } catch (err) {
      return left(AppError(
          message: err.toString(), code: ReLoginErrorCodes.unexpected));
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
    await _tokenService.setUserTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await _secretSharedPreferencesRepository.setE2EKeyPair(newKeyPair);
    final localKey =
        await _messageEncryptionUseCase.generateNewLocalSymmetricKey();
    await _secretSharedPreferencesRepository.setLocalSymmetricKey(localKey);

    await _sharedPreferencesRepository.setIsLogged(true);
    _tokenService.setHTTPAuthorizationAccessToken();
  }
}
