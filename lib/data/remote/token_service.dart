import 'dart:convert';

import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/auth/logout_usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenService {
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final LogoutUsecase _logoutUsecase;
  UserTokens? _userTokens;

  TokenService({
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required LogoutUsecase logoutUsecase,
  })  : _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _logoutUsecase = logoutUsecase;

  Future<UserTokens?>? currentRefreshPromise;

  setUserTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _userTokens = UserTokens(
      refreshToken: refreshToken,
      accessToken: accessToken,
    );
    await _secretSharedPreferencesRepository.setUserTokens(_userTokens!);
  }

  Future<UserTokens?> getUserTokens() async {
    _userTokens ??= await _secretSharedPreferencesRepository.getUserTokens();
    return _userTokens;
  }

  Future<UserTokens?> tryRefreshToken() {
    currentRefreshPromise ??= _refreshToken().then((value) {
      currentRefreshPromise = null;
      return value;
    });

    return currentRefreshPromise!;
  }

  Future<void> setHTTPAuthorizationAccessToken() async {
    final userTokens = await getUserTokens();
    if (userTokens != null) {
      apiClient.options.headers['Authorization'] =
          'Bearer ${userTokens.accessToken}';
    }
  }

  checkTokensExpiration() async {
    final userTokens = await getUserTokens();

    if (userTokens == null) {
      await _logoutUsecase.logoutSoftLocally();
      return;
    }

    bool isExpiredAccess = JwtDecoder.isExpired(userTokens.accessToken);
    bool isExpiredRefresh = JwtDecoder.isExpired(userTokens.refreshToken);

    if (isExpiredRefresh) {
      await _logoutUsecase.logoutSoftLocally();
      return;
    }

    if (isExpiredAccess) {
      await tryRefreshToken();
    }
  }

  Future<UserTokens?> _refreshToken() async {
    final refreshToken = (await getUserTokens())?.refreshToken;

    if (refreshToken == null) {
      return null;
    }

    final newTokens = await _requestNewAccessToken(refreshToken);

    if (newTokens != null) {
      setUserTokens(
        accessToken: newTokens.accessToken,
        refreshToken: newTokens.refreshToken,
      );
    }
    return newTokens;
  }

  Future<UserTokens?> _requestNewAccessToken(String refreshToken) async {
    try {
      final response = await apiClient.post<Map<String, dynamic>>(
        '/get-new-access-token',
        data: jsonEncode({'refreshToken': refreshToken}),
      );

      final String newAccessToken = response.data?['accessToken'];
      final String newRefreshToken = response.data?['refreshToken'];

      return UserTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );
    } catch (err) {
      print("requestNewAccessToken error: ${err}");
      return null;
    }
  }
}
