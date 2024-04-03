import 'package:encrypted_notes/domain/models/user/user.dart';

abstract class UserLocalRepository {
  User? getUser();
  Future setUser(User user);
  Future setUserTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future setBioWebId(List<int> id);
  UserTokens? getUserTokens();
  Future clearData();
}
