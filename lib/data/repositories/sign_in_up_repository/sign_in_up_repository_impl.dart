import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/data/repositories/error_handling.dart';
import 'package:encrypted_notes/domain/models/login/login.dart';
import 'package:encrypted_notes/domain/models/register/register.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';
import 'package:encrypted_notes/extensions/encryption_key_extension.dart';

class SignInUpRepositoryImpl extends SignInUpRepository {
  @override
  Future<LoginUserResponse> singIn({
    required String deviceId,
    required String phone,
    required String password,
    required SimplePublicKey noteEncryptionPublicKey,
  }) async {
    return performNetworkOperation(() async {
      final result = await apiClient.post<Map<String, dynamic>>(
        '/login',
        data: jsonEncode(
          {
            "deviceId": deviceId,
            "phone": phone,
            "password": password,
            "noteEncryptionPublicKey": noteEncryptionPublicKey.toJson()
          },
        ),
      );

      return LoginUserResponse(
        user: User(
          phone: phone,
          bioWedId: null,
          id: result.data?["userId"],
          deviceId: deviceId,
        ),
        tokens: UserTokens(
          accessToken: result.data?["accessToken"],
          refreshToken: result.data?["refreshToken"],
        ),
      );
    });
  }

  @override
  Future<RegisterUserResponse> signUp({
    required String deviceId,
    required String phone,
    required String password,
    required SimplePublicKey noteEncryptionPublicKey,
  }) async {
    return performNetworkOperation(() async {
      final result = await apiClient.post<Map<String, dynamic>>(
        '/register',
        data: jsonEncode(
          {
            "deviceId": deviceId,
            "phone": phone,
            "password": password,
            "noteEncryptionPublicKey": noteEncryptionPublicKey.toJson()
          },
        ),
      );

      return RegisterUserResponse(
        user: User(
          phone: phone,
          bioWedId: null,
          id: result.data?["userId"],
          deviceId: deviceId,
        ),
        tokens: UserTokens(
          accessToken: result.data?["accessToken"],
          refreshToken: result.data?["refreshToken"],
        ),
      );
    });
  }

  @override
  Future logout() async {
    performNetworkOperation(() async {
      await apiClient.post('/logout');
    });
  }
}
