import 'package:encrypted_notes/domain/models/user/user.dart';

abstract class UserLocalRepository {
  User? getUser();
  Future setUser(User user);
  Future setBioWebId(List<int> id);
  Future clearData();
}
