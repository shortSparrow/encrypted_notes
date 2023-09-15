import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwk/jwk.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  final userState = Hive.box(userStateBox);

  @override
  UserStateDb getUserState() {
    final isLogged = userState.get(UserStateKeys.isLogged, defaultValue: false);
    final bioWebId = userState.get(UserStateKeys.bioWebId, defaultValue: null);
    return UserStateDb(isLogged: isLogged, bioWebId: bioWebId);
  }

  @override
  setIsLogged(bool isLogged) async {
    await userState.put(UserStateKeys.isLogged, isLogged);
  }

  @override
  setBioWebId(List<int> id) async {
    await userState.put(UserStateKeys.bioWebId, id);
  }
}

class SecretSharedPreferencesRepositoryImpl
    extends SecretSharedPreferencesRepository {
  @override
  Future<SimpleKeyPair> getE2EKeyPair() async {
    final String? keyPair =
        await secureStorage.read(key: deviceKeyPairForNotes);

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
      key: deviceKeyPairForNotes,
      value: jsonEncode(json),
    );
  }

  @override
  Future<SecretKey> getLocalSymmetricKey() async {
    final secretKey = await secureStorage.read(key: localSecretKey);
    if (secretKey == null || secretKey.isEmpty) {
      throw GeneralFailure(message: "no secret key");
    }
    final key = jsonDecode(secretKey);

    List<int> keyBytes = List<int>.from(key.whereType<dynamic>());

    return SecretKey(keyBytes);
  }

  @override
  Future<void> setLocalSymmetricKey(List<int> key) async {
    await secureStorage.write(key: localSecretKey, value: jsonEncode(key));
  }
}
