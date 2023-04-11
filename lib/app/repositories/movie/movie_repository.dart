import 'package:tmdb/app/models/movie_details_model.dart';
import 'package:tmdb/app/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMoviesTopRated(page);
  Future<int> getTotalPagesTopRated();
  Future<MovieDetailsModel> getMovie(id);
}
