import 'package:tmdb/app/models/movie_details_model.dart';
import 'package:tmdb/app/models/movie_model.dart';

abstract class MovieService {
  Future<List<MovieModel>> getMovies(page);
  Future<MovieDetailsModel> getMovie(id);
  Future<int> getTotalPagesTopRated();
}
