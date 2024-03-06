import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiClient = Dio(
  BaseOptions(
    baseUrl: dotenv.get("API_URL"),

    // Timeout in milliseconds for receiving data
    receiveTimeout: const Duration(seconds: 15),

    // Timeout in milliseconds for sending data
    sendTimeout: const Duration(seconds: 15),
  )
);

