import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../encryption/key_pair_for_notes_use_case.dart';

class EncryptNoteUseCase {
  EncryptNoteUseCase({
    required GetE2EKeyPairForNotesUseCase generateE2EKeyPairUseCase,
  }) : _generateE2EKeyPairUseCase = generateE2EKeyPairUseCase;

  final GetE2EKeyPairForNotesUseCase _generateE2EKeyPairUseCase;

  // AES-CTR with 128 bit keys and HMAC-SHA256 authentication.
  final algorithm = AesCbc.with256bits(
    macAlgorithm: Hmac.sha256(),
  );

  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<SecretKey> getLocalSymmetricSecretKey() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    final secretKey = await storage.read(key: localSecretKey);
    if (secretKey == null || secretKey.isEmpty) {
      throw GeneralFailure(message: "no secret key");
    }
    final key = jsonDecode(secretKey);

    List<int> keyBytes = List<int>.from(key.whereType<dynamic>());

    return SecretKey(keyBytes);
  }

  Future<void> setLocalSymmetricSecretKey(List<int> key) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    await storage.write(key: localSecretKey, value: jsonEncode(key));
  }

  Future<NoteDataForServerEncryptedData> encryptForServer(
    String title,
    String message,
    SimplePublicKey recipientPublicKey,
  ) async {
    final titleBytes = utf8.encode(title);
    final messageBytes = utf8.encode(message);

    final encryptionKey =
        await _generateE2EKeyPairUseCase.getEncryptionKey(recipientPublicKey);

    // Encrypt
    final titleSecretBox = await algorithm.encrypt(
      titleBytes,
      secretKey: encryptionKey,
    );

    final messageSecretBox = await algorithm.encrypt(
      messageBytes,
      secretKey: encryptionKey,
    );

    final titleCipher = EncryptedMessage(
      cipherText: titleSecretBox.cipherText,
      mac: titleSecretBox.mac.bytes,
      nonce: titleSecretBox.nonce,
    );

    final messageCipher = EncryptedMessage(
      cipherText: messageSecretBox.cipherText,
      mac: messageSecretBox.mac.bytes,
      nonce: messageSecretBox.nonce,
    );

    return NoteDataForServerEncryptedData(
      title: titleCipher,
      message: messageCipher,
    );
  }

// TODO create another usecase wich will be only encrypt message, but this sould return EncryptedNote
  Future<EncryptedMessage> encryptForLocal(
    String message,
    SecretKey symmetricEncryptionKey,
  ) async {
    final messageBytes = utf8.encode(message);

    final messageSecretBox = await algorithm.encrypt(
      messageBytes,
      secretKey: symmetricEncryptionKey,
    );

    final messageCipher = EncryptedMessage(
      cipherText: messageSecretBox.cipherText,
      mac: messageSecretBox.mac.bytes,
      nonce: messageSecretBox.nonce,
    );
    return messageCipher;
  }

  Future<String> decryptLocal(
    EncryptedMessage message,
    SecretKey symmetricEncryptionKey,
  ) async {
    final messageSecretBox = await algorithm.decryptString(
      SecretBox(
        message.cipherText,
        nonce: message.nonce,
        mac: Mac(message.mac),
      ),
      secretKey: symmetricEncryptionKey,
    );

    return messageSecretBox;
  }

// TODO figure out how to test (need saved sender and recepirnt keys)
  Future<void> decryptFromServer(
    SimplePublicKey senderPublicKey,
    EncryptedMessage title,
    EncryptedMessage message,
  ) async {
    final decryptionKey =
        await _generateE2EKeyPairUseCase.getDecryptionKey(senderPublicKey);

    final clearTitleText = await algorithm.decryptString(
      SecretBox(
        title.cipherText,
        nonce: title.nonce,
        mac: Mac(title.mac),
      ),
      secretKey: decryptionKey,
    );
    final clearMessageText = await algorithm.decryptString(
      SecretBox(
        message.cipherText,
        nonce: message.nonce,
        mac: Mac(message.mac),
      ),
      secretKey: decryptionKey,
    );

    print("clearText title: ${clearTitleText}");
    print("clearText message: ${clearMessageText}");
  }
}
