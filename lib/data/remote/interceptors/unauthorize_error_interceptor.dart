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
        final requestIsAvailable = error.requestOptions.path != '/login' &&
            error.requestOptions.path != '/register' &&
            error.requestOptions.path != '/get-new-access-token';

        if (error.requestOptions.path == '/get-new-access-token') {
          // TODO maybe parse error (and logut only for 401 or 403)
          await logoutUsecase.logoutSoftLocally();
          MyApp.ctx?.go(AppScreens.confirm_credentials.path);
          return handler.reject(error);
        }

        if (error.response?.statusCode == 401 && requestIsAvailable) {
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
