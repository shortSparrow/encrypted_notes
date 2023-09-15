import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/generate_keys.dart';

class MessageEncryptionUseCase extends GenerateKeys {
  MessageEncryptionUseCase({
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
  }) : _secretSharedPreferencesRepository = secretSharedPreferencesRepository;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;

  SimpleKeyPair? deviceKeyPair;

  Future<EncryptedMessage> encryptMessageE2E(
    String message,
    SimplePublicKey publicKey,
  ) async {
    final encryptionKey = await _getSharedSecretKey(publicKey);

    final messageBytes = utf8.encode(message);

    final messageSecretBox = await algorithmAES.encrypt(
      messageBytes,
      secretKey: encryptionKey,
    );

    final messageCipher = EncryptedMessage(
      cipherText: messageSecretBox.cipherText,
      mac: messageSecretBox.mac.bytes,
      nonce: messageSecretBox.nonce,
    );

    return messageCipher;
  }

  Future<String> decryptMessageE2E(
    EncryptedMessage message,
    SimplePublicKey senderPublicKey,
  ) async {
    final decryptionKey = await _getSharedSecretKey(senderPublicKey);

    final messageSecretBox = await algorithmAES.decryptString(
      SecretBox(
        message.cipherText,
        nonce: message.nonce,
        mac: Mac(message.mac),
      ),
      secretKey: decryptionKey,
    );

    return messageSecretBox;
  }

  Future<SecretKey> _getSharedSecretKey(SimplePublicKey publicKey) async {
    deviceKeyPair ??= await _secretSharedPreferencesRepository.getE2EKeyPair();

    final sharedSecret = await algorithmE2E.sharedSecretKey(
      keyPair: deviceKeyPair!,
      remotePublicKey: publicKey,
    );
    return sharedSecret;
  }

  Future<EncryptedMessage> encryptMessageForLocal(
    String message,
    SecretKey symmetricEncryptionKey,
  ) async {
    final messageBytes = utf8.encode(message);

    final messageSecretBox = await algorithmAES.encrypt(
      messageBytes,
      secretKey: symmetricEncryptionKey,
    );

    return EncryptedMessage(
      cipherText: messageSecretBox.cipherText,
      mac: messageSecretBox.mac.bytes,
      nonce: messageSecretBox.nonce,
    );
  }

  Future<String> decryptMessageForLocal(
    EncryptedMessage message,
    SecretKey symmetricEncryptionKey,
  ) async {
    final decryptedMessage = await algorithmAES.decryptString(
      SecretBox(
        message.cipherText,
        nonce: message.nonce,
        mac: Mac(message.mac),
      ),
      secretKey: symmetricEncryptionKey,
    );

    return decryptedMessage;
  }
}
