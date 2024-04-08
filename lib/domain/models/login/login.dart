import 'package:encrypted_notes/domain/models/user/user.dart';

class LoginUserResponse {
  final User user;
  final UserTokens tokens;

  LoginUserResponse({
    required this.user,
    required this.tokens,
  });
}