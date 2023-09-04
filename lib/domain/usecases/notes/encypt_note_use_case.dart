import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

import '../encryption/generateE2EKeyPairUseCase.dart';

class EncryptNoteUseCase {
  EncryptNoteUseCase({
    required GenerateE2EKeyPairUseCase generateE2EKeyPairUseCase,
  }) : _generateE2EKeyPairUseCase = generateE2EKeyPairUseCase;

  final GenerateE2EKeyPairUseCase _generateE2EKeyPairUseCase;

  Future<void> encryptForServer(
    NoteDataForServerData data,
    SimplePublicKey recipientPublicKey,
  ) async {
    final message = utf8.encode(data.message);

    // AES-CTR with 128 bit keys and HMAC-SHA256 authentication.
    final algorithm = AesCbc.with256bits(
      macAlgorithm: Hmac.sha256(),
    );
    final encryptionKey =
        await _generateE2EKeyPairUseCase.getEncryptionKey(recipientPublicKey);

    final nonce = algorithm.newNonce();

    // Encrypt
    final secretBox = await algorithm.encrypt(
      message,
      secretKey: encryptionKey,
    );

    print('Nonce: ${secretBox.nonce}');
    print('Ciphertext: ${secretBox.cipherText}');
    print('MAC: ${secretBox.mac.bytes}');

    // Decrypt
    final clearText = await algorithm.decryptString(
      secretBox,
      secretKey: encryptionKey,
    );
    print('Cleartext: $clearText');
  }
}
