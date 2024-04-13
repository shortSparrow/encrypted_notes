import 'dart:convert';


abstract class Failure {}

class UnexpectedError extends Failure {
  final String message;
  UnexpectedError({this.message = "Unexpected Error"});
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
}

class AppError<T> {
  final T code;
  final String message;

  AppError({required this.code, this.message = ""});
}
