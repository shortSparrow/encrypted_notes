sealed class RemoteRepositoryError {
  final String message;
  RemoteRepositoryError({required this.message});
}

class ParseServerDataError extends RemoteRepositoryError {
  ParseServerDataError({String message = "Unexpected error"})
      : super(message: message);
}

class NetworkError extends RemoteRepositoryError {
  final int? statusCode;
  NetworkError({
    required super.message,
    required this.statusCode,
  });
}