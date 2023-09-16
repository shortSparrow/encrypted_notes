import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/data/models/secret_shared_preferences_data/secret_shared_preferences_data.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/generate_keys.dart';
import 'package:encrypted_notes/main.dart';
import 'package:jwk/jwk.dart';

class SecretSharedPreferencesRepositoryImpl
    extends SecretSharedPreferencesRepository {
  final UserLocalRepository _userLocalRepository;

  SecretSharedPreferencesRepositoryImpl(
      {required UserLocalRepository userLocalRepository})
      : _userLocalRepository = userLocalRepository;

  Future<SecretSharedPreferencesData> _getStorageForCurrentUser() async {
    final String? userData =
        await secureStorage.read(key: _userLocalRepository.getUser().id);
    final data = jsonDecode(userData ?? '{}');
    return SecretSharedPreferencesData.fromJson(data);
  }

  Future writeToStorage(SecretSharedPreferencesData data) async {
    final String key = _userLocalRepository.getUser().id;

    await secureStorage.write(key: key, value: jsonEncode(data));
  }

  @override
  Future<SimpleKeyPair> getE2EKeyPair() async {
    final storage = await _getStorageForCurrentUser();

    if (storage.deviceKeyPairForNotes != null) {
      final parsedKeyPair = Jwk.fromJson(storage.deviceKeyPairForNotes!);
      return parsedKeyPair.toKeyPair() as SimpleKeyPair;
    }

    throw GeneralFailure(message: "keypair not exist");
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
      throw GeneralFailure(message: "no secret key");
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
}
