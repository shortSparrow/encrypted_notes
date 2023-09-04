import 'package:cryptography/cryptography.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';

class GenerateE2EKeyPairUseCase {
  GenerateE2EKeyPairUseCase();
  final algorithm = X25519(); // TODO temporary, because key length only 32 byes

  Future<SecretKey> getEncryptionKey(SimplePublicKey recipientPublicKey) async {
    final deviceKeyPair = await getDeviceKeyPair();
    final sharedSecret = await algorithm.sharedSecretKey(
      keyPair: deviceKeyPair,
      remotePublicKey: recipientPublicKey,
    );

    return sharedSecret;
  }

  Future<SimpleKeyPair> getDeviceKeyPair() async {
    // TODO load from storage
    final SimpleKeyPair? keyPair = null;
    if (keyPair == null) {
      final deviceKeyPair = await algorithm.newKeyPair();

      // TODO save to storage
      return deviceKeyPair;
    }

// TODO only for avoding error for now. Must be removed
    return await algorithm.newKeyPair();
  }
}
