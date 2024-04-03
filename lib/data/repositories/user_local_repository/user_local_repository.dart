import 'dart:convert';

import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:hive/hive.dart';

abstract class UserKeys {
  static const user = 'user';
  static const tokens = 'tokens';
}

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
  setUserTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await userState.put(
      UserKeys.tokens,
      jsonEncode(
        UserTokens(
          refreshToken: refreshToken,
          accessToken: accessToken,
        ),
      ),
    );
  }

  @override
  UserTokens? getUserTokens() {
    final tokens = userState.get(UserKeys.tokens);
    if (tokens == null) {
      return null;
    }
    final tokensJson = jsonDecode(tokens);

    return UserTokens.fromJson(tokensJson);
  }

  @override
  Future clearData() async {
    await userState.clear();
  }
}
