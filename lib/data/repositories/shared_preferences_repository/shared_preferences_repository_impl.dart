import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  final userState = Hive.box(userStateBox);

  @override
  UserStateDb getUserState() {
    final isLogged = userState.get(UserStateKeys.isLogged, defaultValue: false);
    final bioWebId = userState.get(UserStateKeys.bioWebId, defaultValue: null);
    return UserStateDb(isLogged: isLogged, bioWebId: bioWebId);
  }

  @override
  setIsLogged(bool isLogged) async {
    await userState.put(UserStateKeys.isLogged, isLogged);
  }
  
  @override
  setBioWebId(List<int> id) async {
    await userState.put(UserStateKeys.bioWebId, id);
  }
}
