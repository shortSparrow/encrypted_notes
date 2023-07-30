import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';

abstract class SharedPreferencesRepository {
  UserStateDb getUserState();
  setIsLogged(bool isLogged);
  setBioWebId(List<int> id);
}
