import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';

class LogoutUsecase {
  final AppStateSharedPreferencesRepository _sharedPreferencesRepository;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final UserLocalRepository _userLocalRepository;

  LogoutUsecase({
    required AppStateSharedPreferencesRepository sharedPreferencesRepository,
    required UserLocalRepository userLocalRepository,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
  })  : _sharedPreferencesRepository = sharedPreferencesRepository,
        _userLocalRepository = userLocalRepository,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository;

  Future logoutAndCleanUserData() async {
    await Future.wait([
      _userLocalRepository.clearData(),
      _sharedPreferencesRepository.clearData(),
      _secretSharedPreferencesRepository.clearAllUserData(),
      // TODO send request to logout when back-end will be ready
    ]);
  }

  // logout user and not delete all data
  Future logoutSoftLocally() async {
    await _sharedPreferencesRepository.setIsLogged(false);
    await _secretSharedPreferencesRepository.clearUserTokens();
  }
}
