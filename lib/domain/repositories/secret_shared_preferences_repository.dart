import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';

abstract class SecretSharedPreferencesRepository {
  Future<SimpleKeyPair> getE2EKeyPair();
  Future<void> setE2EKeyPair(SimpleKeyPair keyPair);
  Future<SecretKey> getLocalSymmetricKey();
  Future<void> setLocalSymmetricKey(SecretKey key);
  Future<List<int>> getWebBioId();
  Future<void> setWebBioId(List<int> webBioId);
  Future<void> clearAllUserData();
  Future<void> clearUserTokens();
  Future<UserTokens?> getUserTokens();
  Future<void> setUserTokens(UserTokens userTokens);
}
