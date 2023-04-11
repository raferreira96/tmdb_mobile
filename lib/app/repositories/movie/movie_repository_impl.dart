import 'package:tmdb/app/core/exceptions/failure.dart';
import 'package:tmdb/app/core/helpers/constants.dart';
import 'package:tmdb/app/core/helpers/environments.dart';
import 'package:tmdb/app/core/logger/app_logger.dart';
import 'package:tmdb/app/core/rest/rest_client.dart';
import 'package:tmdb/app/core/rest/rest_client_exception.dart';
import 'package:tmdb/app/models/movie_details_model.dart';
import 'package:tmdb/app/models/movie_model.dart';
import 'package:tmdb/app/repositories/movie/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final RestClient _restClient;
  final AppLogger _log;

  MovieRepositoryImpl({required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;

  @override
  Future<List<MovieModel>> getMoviesTopRated(page) async {
    try {
      final result = await _restClient.auth().get('/movie/top_rated',
          queryParameters: {
            'api_key': Environments.param(Constants.ENV_API_KEY),
            'language': 'pt-BR',
            'page':page
          });
      // List<MovieModel> movies = List<MovieModel>.from(
      //     result.data['results'].map((model) => MovieModel.fromMap(model)));
      // print(movies);
      // return movies;
      return result.data["results"]
          ?.map<MovieModel>(
              (movieResponse) => MovieModel.fromMap(movieResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar a lista de Filmes';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<MovieDetailsModel> getMovie(id) async{
    try {
      final result = await _restClient.auth().get('/movie/$id',
          queryParameters: {
            'api_key': Environments.param(Constants.ENV_API_KEY),
            'language': 'pt-BR'
          });
      // List<MovieModel> movies = List<MovieModel>.from(
      //     result.data['results'].map((model) => MovieModel.fromMap(model)));
      // print(movies);
      // return movies;
      return MovieDetailsModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar o Filme';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }
  
  @override
  Future<int> getTotalPagesTopRated() async {
    try {
      final result = await _restClient.auth().get('/movie/top_rated',
          queryParameters: {
            'api_key': Environments.param(Constants.ENV_API_KEY),
            'language': 'pt-BR'
          });
      // List<MovieModel> movies = List<MovieModel>.from(
      //     result.data['results'].map((model) => MovieModel.fromMap(model)));
      // print(movies);
      // return movies;
      return result.data["total_pages"];
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar total de páginas!';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }
}
