import 'package:tmdb/app/models/movie_details_model.dart';
import 'package:tmdb/app/models/movie_model.dart';
import 'package:tmdb/app/repositories/movie/movie_repository.dart';
import 'package:tmdb/app/services/movie/movie_service.dart';

class MovieServiceImpl implements MovieService {
  final MovieRepository _repository;

  MovieServiceImpl({required MovieRepository movieRepository})
      : _repository = movieRepository;

  @override
  Future<List<MovieModel>> getMovies(page) => _repository.getMoviesTopRated(page);

  @override
  Future<MovieDetailsModel> getMovie(id) => _repository.getMovie(id);
  
  @override
  Future<int> getTotalPagesTopRated() => _repository.getTotalPagesTopRated();
}
