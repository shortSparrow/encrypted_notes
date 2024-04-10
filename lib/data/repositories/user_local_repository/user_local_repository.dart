import 'dart:convert';

import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/models/user_state/user_state.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:hive/hive.dart';

// When user logout we must delete  data for user, when login save again
class UserLocalRepositoryImpl extends UserLocalRepository {
  final userState = Hive.box(HiveBoxes.userBox);

  @override
  User? getUser() {
    final user = userState.get(UserKeys.user);
    if (user == null) {
      return null;
    }
    return User.fromJson(jsonDecode(user));
  }

  @override
  setUser(User user) async {
    await userState.put(UserKeys.user, jsonEncode(user));
  }

  @override
  setBioWebId(List<int> id) async {
    final user = getUser();
    await userState.put(UserKeys.user, user!.copyWith(bioWedId: id));
  }

  @override
  Future clearData() async {
    await userState.clear();
  }
}
