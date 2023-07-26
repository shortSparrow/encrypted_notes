import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  final userState = Hive.box(userStateBox);

  @override
  UserStateDb getUserState() {
    final isLogged = userState.get(UserStateKeys.isLogged);
    return UserStateDb(isLogged: isLogged);
  }

  @override
  setIsLogged(bool isLogged) async {
    userState.put(UserStateKeys.isLogged, isLogged);
  }
}
