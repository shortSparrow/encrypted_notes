import 'package:encrypted_notes/data/models/app_state/app_state.dart';

abstract class AppStateSharedPreferencesRepository {
  AppState getAppState();
  Future setIsLogged(bool isLogged);
  Future clearData();
}
