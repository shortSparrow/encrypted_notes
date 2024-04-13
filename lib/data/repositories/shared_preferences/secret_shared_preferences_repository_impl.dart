import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/data/models/secret_shared_preferences_data/secret_shared_preferences_data.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/generate_keys.dart';
import 'package:encrypted_notes/main.dart';
import 'package:jwk/jwk.dart';

enum GetE2EKeyPairErrorCodes { keyPairNotExist }

enum GetLocalSymmetricKeyErrorCodes { noSecretKey }

class SecretSharedPreferencesRepositoryImpl
    extends SecretSharedPreferencesRepository {
  final UserLocalRepository _userLocalRepository;

  SecretSharedPreferencesRepositoryImpl({
    required UserLocalRepository userLocalRepository,
  }) : _userLocalRepository = userLocalRepository;

  @override
  Future clearAllUserData() async {
    final String key = _userLocalRepository.getUser()!.id.toString();
    await secureStorage.delete(key: key);
  }

  Future<SecretSharedPreferencesData> _getStorageForCurrentUser() async {
    final String? userData = await secureStorage.read(
      key: _userLocalRepository.getUser()!.id.toString(),
    );
    final data = jsonDecode(userData ?? '{}');
    return SecretSharedPreferencesData.fromJson(data);
  }

  Future writeToStorage(SecretSharedPreferencesData data) async {
    final String key = _userLocalRepository.getUser()!.id.toString();

    await secureStorage.write(key: key, value: jsonEncode(data));
  }

  @override
  Future<SimpleKeyPair> getE2EKeyPair() async {
    final storage = await _getStorageForCurrentUser();

    if (storage.deviceKeyPairForNotes != null) {
      final parsedKeyPair = Jwk.fromJson(storage.deviceKeyPairForNotes!);
      return parsedKeyPair.toKeyPair() as SimpleKeyPair;
    }

    throw AppError(
      message: "keypair not exist",
      code: GetE2EKeyPairErrorCodes.keyPairNotExist,
    );
  }

  @override
  Future<void> setE2EKeyPair(SimpleKeyPair keyPair) async {
    final storage = await _getStorageForCurrentUser();
    final jwk = await Jwk.fromKeyPair(keyPair);
    final json = jwk.toJson();

    await writeToStorage(storage.copyWith(deviceKeyPairForNotes: json));
  }

  @override
  Future<SecretKey> getLocalSymmetricKey() async {
    final storage = await _getStorageForCurrentUser();
    if (storage.localSymmetricKey == null) {
      throw AppError(
        message: "no secret key",
        code: GetLocalSymmetricKeyErrorCodes.noSecretKey,
      );
    }
    final key = Jwk.fromJson(storage.localSymmetricKey!);

    return key.toSecretKey();
  }

  @override
  Future<void> setLocalSymmetricKey(SecretKey key) async {
    final storage = await _getStorageForCurrentUser();
    final jwk =
        await Jwk.fromSecretKey(key, cipher: GenerateKeys().algorithmAES);
    final json = jwk.toJson();

    await writeToStorage(storage.copyWith(localSymmetricKey: json));
  }

  @override
  Future<List<int>> getWebBioId() async {
    final storage = await _getStorageForCurrentUser();
    final webBioIdJson = jsonDecode(storage.webBioId ?? '[]');
    List<int> webBioIdBytes = List<int>.from(webBioIdJson.whereType<dynamic>());
    return webBioIdBytes;
  }

  @override
  Future<void> setWebBioId(List<int> webBioId) async {
    final storage = await _getStorageForCurrentUser();
    final json = jsonEncode(webBioId);
    await writeToStorage(storage.copyWith(webBioId: json));
  }

  @override
  Future<UserTokens?> getUserTokens() async {
    final storage = await _getStorageForCurrentUser();
    if (storage.userTokens == null) {
      return null;
    }

    return UserTokens.fromJson(storage.userTokens!);
  }

  @override
  Future setUserTokens(UserTokens userTokens) async {
    final storage = await _getStorageForCurrentUser();
    await writeToStorage(storage.copyWith(userTokens: userTokens.toJson()));
  }

  @override
  Future<void> clearUserTokens() async {
    final storage = await _getStorageForCurrentUser();
    await writeToStorage(storage.copyWith(userTokens: null));
  }
}
