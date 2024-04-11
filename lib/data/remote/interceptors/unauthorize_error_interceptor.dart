import 'package:dio/dio.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/data/remote/token_service.dart';
import 'package:encrypted_notes/domain/usecases/auth/logout_usecase.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/main.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:go_router/go_router.dart';

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
        final LogoutUsecase logoutUsecase = sl();
        print("ERROR: ${error.response}");
        print("error.requestOptions.path: ${error.requestOptions.path}");

        if (error.requestOptions.path == '/get-new-access-token') {
          final statuesForRelogin = [401, 400, 404];
          if (statuesForRelogin.contains(error.response?.statusCode)) {
            await logoutUsecase.logoutSoftLocally();
            MyApp.ctx?.go(AppScreens.confirm_credentials.path);
          }

          return handler.reject(error);
        }

        final requestIsAvailableUnauthorizeError =
            error.requestOptions.path != '/login' &&
                error.requestOptions.path != '/register' &&
                error.requestOptions.path != '/get-new-access-token';

        final statuesForUpdateToken = [401, 402, 403];
        if (statuesForUpdateToken.contains(error.response?.statusCode) &&
            requestIsAvailableUnauthorizeError) {
          final tokens = await tokenService.tryRefreshToken();
          if (tokens != null) {
            await tokenService.setHTTPAuthorizationAccessToken();

            error.requestOptions.headers['Authorization'] =
                'Bearer ${tokens.accessToken}';

            final response = await apiClient.fetch(error.requestOptions);

            return handler.resolve(response);
          } else {
            await logoutUsecase.logoutSoftLocally();
            MyApp.ctx?.go(AppScreens.confirm_credentials.path);
            return handler.next(error);
          }
        }

        return handler.next(error);
      },
    ),
  );
}
