import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class GeneralFailure extends Failure {
  final String message;
  GeneralFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class JsFailure extends Failure {
  final String message;
  final String reason;
  JsFailure({required this.reason, required this.message});

  factory JsFailure.fromJson(Map<String, dynamic> json) {
    return JsFailure(reason: json['reason'], message: json['message']);
  }

  factory JsFailure.decodeFromJson(String e) {
    Map<String, dynamic> failure = jsonDecode(e);
    return JsFailure.fromJson(failure);
  }

  @override
  List<Object> get props => [message, reason];
}

class UnexpectedFailure extends Failure {}

class NetworkFailure extends GeneralFailure {
  int statusCode;
  String message;

  NetworkFailure({
    int? statusCode,
    String? message,
  })  : statusCode = statusCode ?? 0,
        message = message ?? 'Unknown error',
        super(message: message ?? 'Unknown error');

  @override
  List<Object> get props => [statusCode, message];
}
