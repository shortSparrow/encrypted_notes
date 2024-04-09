import 'package:dio/dio.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/data/remote/token_service.dart';
import 'package:encrypted_notes/injection.dart';

addUnauthorizeErrorInterceptor() {
  apiClient.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        final TokenService tokenService = sl();
        print("ERROR: ${error.response}");
        print("error.requestOptions.path: ${error.requestOptions.path}");
        final requestIsAvailable = error.requestOptions.path != '/login' &&
            error.requestOptions.path != '/register' &&
            error.requestOptions.path != '/get-new-access-token';

        if (error.requestOptions.path != '/get-new-access-token') {
          // TODO parse error and  navigate to login if needed
        }

        if (error.response?.statusCode == 401 && requestIsAvailable) {
          final tokens = await tokenService.tryRefreshToken();
          if (tokens != null) {
            tokenService.setHTTPAuthorizationAccessToken();

            error.requestOptions.headers['Authorization'] =
                'Bearer ${tokens.accessToken}';

            final response = await apiClient.fetch(error.requestOptions);
            print("response: ${response}");

            return handler.resolve(response);
          } else {
            return handler.next(error);
            // TODO navigate to login
          }
        }
      },
    ),
  );
}
