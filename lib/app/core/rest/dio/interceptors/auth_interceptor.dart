import 'package:dio/dio.dart';
import 'package:tmdb/app/core/helpers/constants.dart';
import 'package:tmdb/app/core/local_storage/local_storage.dart';
import 'package:tmdb/app/core/logger/app_logger.dart';
import 'package:tmdb/app/modules/core/auth/auth_store.dart';

class AuthInterceptor extends Interceptor {
  final LocalSecureStorage _localSecureStorage;
  final AuthStore _authStore;
  AuthInterceptor(
      {required LocalStorage localStorage,
      required LocalSecureStorage localSecureStorage,
      required AuthStore authStore,
      required AppLogger log})
      : _localSecureStorage = localSecureStorage,
        _authStore = authStore;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired =
        options.extra[Constants.REST_CLIENT_AUTH_REQUIRED] ?? false;
    if (authRequired) {
      final sessionId =
          await _localSecureStorage.read(Constants.LOCAL_STORAGE_SESSIONID);
      if (sessionId == null) {
        _authStore.logout();
        return handler.reject(DioError(
            requestOptions: options,
            error: 'Expired Session ID',
            type: DioErrorType.cancel));
      }
      options.queryParameters['session_id'] = sessionId;
    } else {
      options.queryParameters.remove('session_id');
    }
    handler.next(options);
  }

}
