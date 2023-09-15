import 'package:cryptography/cryptography.dart';

class GenerateKeys {
  final algorithmE2E = X25519();
  final algorithmAES = AesCbc.with256bits(
    macAlgorithm: Hmac.sha256(),
  );

  Future<SimpleKeyPair> generateNewE2EKeyPair() {
    return algorithmE2E.newKeyPair();
  }

  Future<SecretKey> generateNewLocalSymmetricKey() async {
    return algorithmAES.newSecretKey();
  }
}
