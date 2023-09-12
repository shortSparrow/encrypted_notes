import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwk/jwk.dart';

class GetE2EKeyPairForNotesUseCase {
  GetE2EKeyPairForNotesUseCase();
  final algorithm = X25519(); // TODO temporary, because key length only 32 byes

  AndroidOptions getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<SecretKey> _getSharedSecretKey(SimplePublicKey publicKey) async {
    final deviceKeyPair = await getDeviceKeyPair();
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: deviceKeyPair,
      remotePublicKey: publicKey,
    );
    return sharedSecret;
  }

  Future<SecretKey> getEncryptionKey(SimplePublicKey recipientPublicKey) async {
    final sharedSecret = await _getSharedSecretKey(recipientPublicKey);
    return sharedSecret;
  }

  Future<SecretKey> getDecryptionKey(SimplePublicKey senderPublicKey) async {
    final sharedSecret = await _getSharedSecretKey(senderPublicKey);
    return sharedSecret;
  }

  Future<SimpleKeyPair> getDeviceKeyPair() async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

    final String? keyPair = await storage.read(key: deviceKeyPairForNotes);
    if (keyPair == null) {
      final deviceKeyPair = await algorithm.newKeyPair();

      final jwk = await Jwk.fromKeyPair(deviceKeyPair);

      final json = jwk.toJson();
      await storage.write(
        key: deviceKeyPairForNotes,
        value: jsonEncode(json),
      );
      return deviceKeyPair;
    } else {
      final gson = jsonDecode(keyPair);
      final parsedKeyPair = Jwk.fromJson(gson);
      return parsedKeyPair.toKeyPair() as SimpleKeyPair;
    }
  }

  // ********************************************************************************

// FIXME only for testing (must be deleted when back will be ready)
  Future<SimpleKeyPair> getAliceDeviceKeyPair() async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

    final String? keyPair =
        await storage.read(key: 'aliceDeviceKeyPairForNotes');
    if (keyPair == null) {
      final deviceKeyPair = await algorithm.newKeyPair();

      final jwk = await Jwk.fromKeyPair(deviceKeyPair);
      final json = jwk.toJson();
      await storage.write(
        key: 'aliceDeviceKeyPairForNotes',
        value: jsonEncode(json),
      );
      return deviceKeyPair;
    } else {
      final gson = jsonDecode(keyPair);
      final parsedKeyPair = Jwk.fromJson(gson);
      return parsedKeyPair.toKeyPair() as SimpleKeyPair;
    }
  }

  Future<SecretKey> getAliceEncryptionKey(
    SimplePublicKey recipientPublicKey,
  ) async {
    final deviceKeyPair = await getAliceDeviceKeyPair();
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: deviceKeyPair,
      remotePublicKey: recipientPublicKey,
    );

    return sharedSecret;
  }

// ********************************************************************************
  Future<SimpleKeyPair> getBobDeviceKeyPair() async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

    final String? keyPair = await storage.read(key: 'bobDeviceKeyPairForNotes');
    if (keyPair == null) {
      final deviceKeyPair = await algorithm.newKeyPair();

      final jwk = await Jwk.fromKeyPair(deviceKeyPair);
      final json = jwk.toJson();
      await storage.write(
        key: 'bobDeviceKeyPairForNotes',
        value: jsonEncode(json),
      );
      return deviceKeyPair;
    } else {
      final gson = jsonDecode(keyPair);
      final parsedKeyPair = Jwk.fromJson(gson);
      return parsedKeyPair.toKeyPair() as SimpleKeyPair;
    }
  }

  Future<SecretKey> getBobEncryptionKey(
    SimplePublicKey recipientPublicKey,
  ) async {
    final deviceKeyPair = await getBobDeviceKeyPair();
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: deviceKeyPair,
      remotePublicKey: recipientPublicKey,
    );

    return sharedSecret;
  }
  // ********************************************************************************
}
