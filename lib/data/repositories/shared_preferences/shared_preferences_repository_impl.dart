import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/models/user_state/user_state.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  final userState = Hive.box(HiveBoxes.userStateBox);

  @override
  UserStateDb getUserState() {
    final isLogged = userState.get(UserStateKeys.isLogged, defaultValue: false);
    final deviceId = userState.get(UserStateKeys.deviceId, defaultValue: '');

    return UserStateDb(isLogged: isLogged, deviceId: deviceId);
  }

  @override
  setIsLogged(bool isLogged) async {
    await userState.put(UserStateKeys.isLogged, isLogged);
  }

// FIXME note used now
  @override
  Future setUniqueDeviceId(String deviceId) async {
    await userState.put(UserStateKeys.deviceId, deviceId);
  }
}
