import 'dart:convert';

import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:hive/hive.dart';

abstract class UserKeys {
  static const user = 'user';
}

// When user logout we must delete  data for user, when login save again
class UserLocalRepositoryImpl extends UserLocalRepository {
  final userState = Hive.box(HiveBoxes.userBox);

  @override
  User getUser() {
    return User.fromJson(jsonDecode(userState.get(UserKeys.user)));
  }

  @override
  setUser(User user) async {
    await userState.put(UserKeys.user, jsonEncode(user));
  }

  @override
  setBioWebId(List<int> id) async {
    final user = getUser();
    await userState.put(UserKeys.user, user.copyWith(bioWedId: id));
  }

  @override
  setToken(String token) async {
    final user = getUser();
    await userState.put(UserKeys.user, user.copyWith(token: token));
  }

  @override
  Future clearData() async {
    await userState.clear();
  }
}
