import 'package:encrypted_notes/data/models/user_state/user_state.dart';

abstract class SharedPreferencesRepository {
  UserStateDb getUserState();
  Future setIsLogged(bool isLogged);
}

