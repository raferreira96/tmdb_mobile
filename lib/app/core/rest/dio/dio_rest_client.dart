import 'package:dio/dio.dart';
import 'package:tmdb/app/core/helpers/constants.dart';
import 'package:tmdb/app/core/helpers/environments.dart';
import 'package:tmdb/app/core/local_storage/local_storage.dart';
import 'package:tmdb/app/core/logger/app_logger.dart';
import 'package:tmdb/app/core/rest/dio/interceptors/auth_interceptor.dart';
import 'package:tmdb/app/core/rest/rest_client.dart';
import 'package:tmdb/app/core/rest/rest_client_exception.dart';
import 'package:tmdb/app/core/rest/rest_client_response.dart';
import 'package:tmdb/app/modules/core/auth/auth_store.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;
  final _defaultOptions = BaseOptions(
    baseUrl: Environments.param(Constants.ENV_BASE_URL) ?? '',
    connectTimeout:
        int.parse(Environments.param(Constants.ENV_CONNECTION_TIMEOUT) ?? '0'),
    receiveTimeout:
        int.parse(Environments.param(Constants.ENV_RECEIVE_TIMEOUT) ?? '0'),
  );

  DioRestClient({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required AuthStore authStore,
    required AppLogger log,
    BaseOptions? baseOptions}) {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(localStorage: localStorage, localSecureStorage: localSecureStorage, authStore: authStore,log: log),
      LogInterceptor(requestBody: true, responseBody: true)
    ]);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }

  Never _throwRestClientException(DioError dioError) {
    final response = dioError.response;

    throw RestClientException(
        error: dioError.error,
        message: response?.statusMessage,
        statusCode: response?.statusCode,
        response: RestClientResponse(
            data: response?.data,
            statusCode: response?.statusCode,
            statusMessage: response?.statusMessage));
  }
  
}
