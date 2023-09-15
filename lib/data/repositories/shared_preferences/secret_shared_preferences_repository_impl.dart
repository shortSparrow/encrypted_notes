import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/models/secret_shared_preferences_data/secret_shared_preferences_data.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/main.dart';
import 'package:jwk/jwk.dart';

class SecretSharedPreferencesRepositoryImpl
    extends SecretSharedPreferencesRepository {
  final UserLocalRepository _userLocalRepository;

  SecretSharedPreferencesRepositoryImpl(
      {required UserLocalRepository userLocalRepository})
      : _userLocalRepository = userLocalRepository;

  // Future<SecretSharedPreferencesData> getStorageForCurrentUser() async {
  //   final String? userData =
  //       await secureStorage.read(key: _userLocalRepository.getUser().id);

  //   final data =
  //       SecretSharedPreferencesData.fromJson(jsonDecode(userData ?? ""));
  //       return data;
  // }

  Future readFromStorage() async {}

  // TODO we must save data in special user Field, and when he login again this data must be restored
  @override
  Future<SimpleKeyPair> getE2EKeyPair() async {
    final String? keyPair =
        await secureStorage.read(key: SecureStorageKeys.deviceKeyPairForNotes);

    if (keyPair != null) {
      final gson = jsonDecode(keyPair);
      final parsedKeyPair = Jwk.fromJson(gson);
      return parsedKeyPair.toKeyPair() as SimpleKeyPair;
    }

    throw GeneralFailure(message: "keypair not exist");
  }

  @override
  Future<void> setE2EKeyPair(SimpleKeyPair keyPair) async {
    final jwk = await Jwk.fromKeyPair(keyPair);

    final json = jwk.toJson();
    await secureStorage.write(
      key: SecureStorageKeys.deviceKeyPairForNotes,
      value: jsonEncode(json),
    );
  }

  @override
  Future<SecretKey> getLocalSymmetricKey() async {
    final secretKey =
        await secureStorage.read(key: SecureStorageKeys.localSecretKey);
    if (secretKey == null || secretKey.isEmpty) {
      throw GeneralFailure(message: "no secret key");
    }
    final key = jsonDecode(secretKey);

    List<int> keyBytes = List<int>.from(key.whereType<dynamic>());

    return SecretKey(keyBytes);
  }

  @override
  Future<void> setLocalSymmetricKey(List<int> key) async {
    await secureStorage.write(
        key: SecureStorageKeys.localSecretKey, value: jsonEncode(key));
  }

  @override
  Future<List<int>> getWebBioId() async {
    final webBioId = await secureStorage.read(key: SecureStorageKeys.webBioId);
    final webBioIdJson = jsonDecode(webBioId ?? '[]');
    List<int> webBioIdBytes = List<int>.from(webBioIdJson.whereType<dynamic>());
    return webBioIdBytes;
  }

  @override
  Future<void> setWebBioId(List<int> webBioId) async {
    final json = jsonEncode(webBioId);
    await secureStorage.write(key: SecureStorageKeys.webBioId, value: json);
  }
}
