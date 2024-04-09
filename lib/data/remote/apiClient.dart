import 'dart:io';

import 'package:dio/dio.dart';
import 'package:encrypted_notes/data/remote/interceptors/unauthorize_error_interceptor.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/injection.dart';

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

setupApiClientInterceptors() {
  addUnauthorizeErrorInterceptor();
}
