import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String phone,
    required List<int>? bioWedId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserTokens with _$UserTokens {
  const factory UserTokens({
    required String refreshToken,
    required String accessToken,
  }) = _UserTokens;

  factory UserTokens.fromJson(Map<String, dynamic> json) => _$UserTokensFromJson(json);
}
