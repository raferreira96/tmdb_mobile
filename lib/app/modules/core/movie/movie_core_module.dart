import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/repositories/movie/movie_repository.dart';
import 'package:tmdb/app/repositories/movie/movie_repository_impl.dart';
import 'package:tmdb/app/services/movie/movie_service.dart';
import 'package:tmdb/app/services/movie/movie_service_impl.dart';

class MovieCoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton<MovieRepository>((i) => MovieRepositoryImpl(restClient: i(), log: i()), export: true),
    Bind.lazySingleton<MovieService>((i) => MovieServiceImpl(movieRepository: i()), export: true),
  ];
}