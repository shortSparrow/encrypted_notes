import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';

abstract class SharedPreferencesRepository {
  UserStateDb getUserState();
  setIsLogged(bool isLogged);
  setBioWebId(List<int> id);
}

abstract class SecretSharedPreferencesRepository {
  Future<SimpleKeyPair> getE2EKeyPair();
  Future<void> setE2EKeyPair(SimpleKeyPair keyPair);
  Future<SecretKey> getLocalSymmetricKey();
  Future<void> setLocalSymmetricKey(List<int> key);
}
