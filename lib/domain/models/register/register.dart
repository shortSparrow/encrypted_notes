import 'package:encrypted_notes/domain/models/user/user.dart';

class RegisterUserResponse {
  final User user;
  final UserTokens tokens;

  RegisterUserResponse({
    required this.user,
    required this.tokens,
  });
}