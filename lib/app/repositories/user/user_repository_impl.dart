import 'package:tmdb/app/core/exceptions/failure.dart';
import 'package:tmdb/app/core/helpers/constants.dart';
import 'package:tmdb/app/core/helpers/environments.dart';
import 'package:tmdb/app/core/logger/app_logger.dart';
import 'package:tmdb/app/core/rest/rest_client.dart';
import 'package:tmdb/app/core/rest/rest_client_exception.dart';
import 'package:tmdb/app/models/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;

  UserRepositoryImpl({required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;

  @override
  Future<String> requestToken() async {
    try {
      final result = await _restClient
          .unauth()
          .get('/authentication/token/new', queryParameters: {
        'api_key': Environments.param(Constants.ENV_API_KEY)
      }, headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': Environments.param(Constants.ENV_READ_TOKEN)
      });
      return result.data['request_token'];
    } on RestClientException catch (e, s) {
      _log.error('Request Token Error', e, s);
      throw Failure(message: 'Não é possível se comunicar com o Servidor!');
    }
  }

  @override
  Future<String> createSession(requestToken) async {
    try {
      final result =
          await _restClient.unauth().post('/authentication/session/new', data: {
        'request_token': requestToken
      }, queryParameters: {
        'api_key': Environments.param(Constants.ENV_API_KEY)
      }, headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': Environments.param(Constants.ENV_READ_TOKEN)
      });
      return result.data['session_id'];
    } on RestClientException catch (e, s) {
      _log.error('Session ID Creation Error', e, s);
      throw Failure(message: 'Erro ao iniciar Sessão!');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    final tokenRequest = await requestToken();
    try {
      final result = await _restClient
          .unauth()
          .post('/authentication/token/validate_with_login', data: {
        'username': username,
        'password': password,
        'request_token': tokenRequest
      }, queryParameters: {
        'api_key': Environments.param(Constants.ENV_API_KEY)
      }, headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': Environments.param(Constants.ENV_READ_TOKEN)
      });
      final confirmedRequestToken = result.data['request_token'];
      final createSessionId = createSession(confirmedRequestToken);
      return createSessionId;
    } on RestClientException catch (e, s) {
      _log.error('Confirm Request Token Error', e, s);
      throw Failure(message: 'Usuário e/ou Senha inválidos!');
    }
  }

  @override
  Future<UserModel> getUserBySession() async {
    try {
      final result = await _restClient.auth().get('/account', queryParameters: {
        'api_key': Environments.param(Constants.ENV_API_KEY)
      });
      return UserModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _log.error('Get User Logged Error', e, s);
      throw Failure(message: 'Erro ao buscar dados do Usuário!');
    }
  }

  @override
  Future<bool> deleteSession(sessionId) async {
    try {
      final result = await _restClient.auth().delete('/authentication/session',
          data: {
            'session_id': sessionId
          },
          queryParameters: {
            'api_key': Environments.param(Constants.ENV_API_KEY)
          });
      return result.data['success'];
    } on RestClientException catch (e, s) {
      _log.error('Delete Session Error', e, s);
      throw Failure(message: 'Erro ao tentar realizar Logout');
    }
  }
}
