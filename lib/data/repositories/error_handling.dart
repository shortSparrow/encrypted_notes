import 'package:dio/dio.dart';
import 'package:encrypted_notes/domain/failures/remote_repository_failures.dart';

// TODO fix this in right way
const NO_INTERNET_CODE = 999;
Future<T> performNetworkOperation<T>(Future<T> Function() operation) async {
  try {
    return await operation();
  } on DioException catch (e) {
    print("Network error ${e}");
    throw NetworkError(
      statusCode: e.response?.statusCode ?? NO_INTERNET_CODE,
      message: getErrorMessage(e),
    );
  } catch (e) {
    throw ParseServerDataError(message: "Unexpected Error: ${e}");
  }
}

String getErrorMessage(DioException e) {
  if(e.response?.statusCode == null && e.response?.data?["message"] == null) {
    return "Problem with internet connection";
  }
  return e.response?.data?["message"] ?? "";
}