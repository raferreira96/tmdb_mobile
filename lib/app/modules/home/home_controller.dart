import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb/app/core/exceptions/failure.dart';
import 'package:tmdb/app/core/life_cycle/controller_life_cycle.dart';
import 'package:tmdb/app/core/ui/widgets/loader.dart';
import 'package:tmdb/app/core/ui/widgets/messages.dart';
import 'package:tmdb/app/models/movie_details_model.dart';
import 'package:tmdb/app/models/movie_model.dart';
import 'package:tmdb/app/services/movie/movie_service.dart';
import 'package:tmdb/app/services/user/user_service.dart';

part 'home_controller.g.dart';

enum MoviePageType { list, grid }

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final MovieService _movieService;
  final UserService _userService;

  HomeControllerBase(
      {required MovieService movieService,
      required UserService userService})
      : _movieService = movieService,
        _userService = userService;

  @readonly
  var _listMovies = <MovieModel>[];

  MovieDetailsModel? movieDetail;

  var page = Observable<int>(1);

  int _totalPages = 1;

  bool hasMore = true;

  @readonly
  var _moviePageTypeSelected = MoviePageType.list;

  @override
  Future<void> onReady() async {
    try {
      Loader.show();
      await _getMovies();
      await _getTotalPages();
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> fowardPage() async {
    if (page.value > 0 && page.value <= _totalPages) {
      page.value++;
      await _getMovies();
    }
  }

  @action
  Future<void> backPage() async {
    if (page.value == 1) {
      page.value = 1;
      Messages.info('Esta é a primeira página.');
    } else {
      page.value--;
      await _getMovies();
    }
  }

  @action
  Future<void> _getMovies() async {
    try {
      final pageParam = page.value;
      final movies = await _movieService.getMovies(pageParam);
      if (movies.isNotEmpty) {
        _listMovies = [...movies];
      } else {
        hasMore = false;
      }
    } catch (e) {
      Messages.alert('Erro ao buscar a lista de Filmes');
      //throw Exception();
    }
  }

  @action
  Future<void> _getTotalPages() async {
    try {
      final total = await _movieService.getTotalPagesTopRated();
      _totalPages = total;
    } catch (e) {
      Messages.alert('Erro ao buscar o total de páginas!');
      //throw Exception();
    }
  }

  @action
  Future<MovieDetailsModel?> getMovie(id) async {
    try {
      final movie = await _movieService.getMovie(id);
      return movie;
    } catch (e) {
      Messages.alert('Erro ao buscar o Filme');
      //throw Exception();
    }
  }

  @action
  void changeTabMovie(MoviePageType moviePageType) {
    _moviePageTypeSelected = moviePageType;
  }

  @action
  Future<void> logout() async {
    try {
      Loader.show();
      await _userService.logout();
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e) {
      final errorMessage = e.message ?? 'Erro ao realizar o logout!';
      Loader.hide();
      Messages.alert(errorMessage);
    }
  }
}
