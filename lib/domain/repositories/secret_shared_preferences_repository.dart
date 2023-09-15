import 'package:cryptography/cryptography.dart';

abstract class SecretSharedPreferencesRepository {
  Future<SimpleKeyPair> getE2EKeyPair();
  Future<void> setE2EKeyPair(SimpleKeyPair keyPair);
  Future<SecretKey> getLocalSymmetricKey();
  Future<void> setLocalSymmetricKey(List<int> key);
  Future<List<int>> getWebBioId();
  Future<void> setWebBioId(List<int> webBioId);
}
