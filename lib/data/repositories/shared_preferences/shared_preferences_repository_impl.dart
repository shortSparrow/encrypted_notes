import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/models/app_state/app_state.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppStateSharedPreferencesRepositoryImpl extends AppStateSharedPreferencesRepository {
  final appState = Hive.box(HiveBoxes.appStateBox);

  @override
  AppState getAppState() {
    final isLogged = appState.get(AppStateKeys.isLogged, defaultValue: false);

    return AppState(isLogged: isLogged);
  }

  @override
  setIsLogged(bool isLogged) async {
    await appState.put(AppStateKeys.isLogged, isLogged);
  }


  @override
  Future clearData() async {
    await appState.clear();
  }
}
