import 'dart:convert';

import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenService {
  final UserLocalRepository _userLocalRepository;
  final SharedPreferencesRepository _sharedPreferencesRepository;

  TokenService({
    required UserLocalRepository userLocalRepository,
    required SharedPreferencesRepository sharedPreferencesRepository,
  })  : _userLocalRepository = userLocalRepository,
        _sharedPreferencesRepository = sharedPreferencesRepository;

  Future<UserTokens?>? currentRefreshPromise;

  Future<UserTokens?> tryRefreshToken() {
    currentRefreshPromise ??= _refreshToken().then((value) {
      currentRefreshPromise = null;
      return value;
    });

    return currentRefreshPromise!;
  }

  Future<UserTokens?> _refreshToken() async {
    final oldTokens = _userLocalRepository.getUserTokens();
    final refreshToken = oldTokens?.refreshToken;

    if (refreshToken == null) {
      return null;
    }

    final newTokens = await _requestNewAccessToken(refreshToken);

    if (newTokens != null) {
      _userLocalRepository.setUserTokens(
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

  void setHTTPAuthorizationAccessToken() {
    final tokens = _userLocalRepository.getUserTokens();
    if (tokens != null) {
      apiClient.options.headers['Authorization'] =
          'Bearer ${tokens.accessToken}';
    }
  }

  checkTokensExpiration() async {
    final tokens = _userLocalRepository.getUserTokens();
    if (tokens == null) {
      // TODO not delete keys just navigate to login. But what happens if user login with another credentials?
      await _sharedPreferencesRepository.setIsLogged(false);
      return;
    }

    bool isExpiredAccess = JwtDecoder.isExpired(tokens.accessToken);
    bool isExpiredRefresh = JwtDecoder.isExpired(tokens.refreshToken);

    if (isExpiredRefresh) {
      // TODO not delete keys just navigate to login. But what happens if user login with another credentials?
      await _sharedPreferencesRepository.setIsLogged(false);
      return;
    }

    if (isExpiredAccess) {
      await tryRefreshToken();
    }
  }
}
