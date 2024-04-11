import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/domain/models/login/login.dart';
import 'package:encrypted_notes/domain/models/register/register.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
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
    try {
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
    } on DioException catch (e) {
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data["message"],
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<RegisterUserResponse> signUp({
    required String deviceId,
    required String phone,
    required String password,
    required SimplePublicKey noteEncryptionPublicKey,
  }) async {
    try {
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
    } on DioException catch (e) {
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data["message"],
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future logout() async {
    try {
      await apiClient.post('/logout');
    } on DioException catch (e) {
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data["message"],
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }
}
