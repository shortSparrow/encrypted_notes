import 'dart:io';

import 'package:dio/dio.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/injection.dart';

// TODO коли отримуємо 401 беремо refresh-token і йдемо поновий access-token
final apiClient = Dio(
  BaseOptions(
    // baseUrl: dotenv.get("API_URL"),
    // baseUrl: 'http://10.0.2.2:3000',
    baseUrl:
        Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000',

    // Timeout in milliseconds for receiving data
    receiveTimeout: const Duration(seconds: 15),

    // Timeout in milliseconds for sending data
    sendTimeout: const Duration(seconds: 15),
  ),
);

void setHTTPAccessToken() {
  final UserLocalRepository userLocalRepository = sl();
  final tokens = userLocalRepository.getUserTokens();
  if (tokens != null) {
    print("set token: ${tokens.accessToken}");
    apiClient.options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
  }
}
