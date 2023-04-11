// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_listMoviesAtom =
      Atom(name: 'HomeControllerBase._listMovies', context: context);

  List<MovieModel> get listMovies {
    _$_listMoviesAtom.reportRead();
    return super._listMovies;
  }

  @override
  List<MovieModel> get _listMovies => listMovies;

  @override
  set _listMovies(List<MovieModel> value) {
    _$_listMoviesAtom.reportWrite(value, super._listMovies, () {
      super._listMovies = value;
    });
  }

  late final _$_moviePageTypeSelectedAtom =
      Atom(name: 'HomeControllerBase._moviePageTypeSelected', context: context);

  MoviePageType get moviePageTypeSelected {
    _$_moviePageTypeSelectedAtom.reportRead();
    return super._moviePageTypeSelected;
  }

  @override
  MoviePageType get _moviePageTypeSelected => moviePageTypeSelected;

  @override
  set _moviePageTypeSelected(MoviePageType value) {
    _$_moviePageTypeSelectedAtom
        .reportWrite(value, super._moviePageTypeSelected, () {
      super._moviePageTypeSelected = value;
    });
  }

  late final _$fowardPageAsyncAction =
      AsyncAction('HomeControllerBase.fowardPage', context: context);

  @override
  Future<void> fowardPage() {
    return _$fowardPageAsyncAction.run(() => super.fowardPage());
  }

  late final _$backPageAsyncAction =
      AsyncAction('HomeControllerBase.backPage', context: context);

  @override
  Future<void> backPage() {
    return _$backPageAsyncAction.run(() => super.backPage());
  }

  late final _$_getMoviesAsyncAction =
      AsyncAction('HomeControllerBase._getMovies', context: context);

  @override
  Future<void> _getMovies() {
    return _$_getMoviesAsyncAction.run(() => super._getMovies());
  }

  late final _$_getTotalPagesAsyncAction =
      AsyncAction('HomeControllerBase._getTotalPages', context: context);

  @override
  Future<void> _getTotalPages() {
    return _$_getTotalPagesAsyncAction.run(() => super._getTotalPages());
  }

  late final _$getMovieAsyncAction =
      AsyncAction('HomeControllerBase.getMovie', context: context);

  @override
  Future<MovieDetailsModel?> getMovie(dynamic id) {
    return _$getMovieAsyncAction.run(() => super.getMovie(id));
  }

  late final _$logoutAsyncAction =
      AsyncAction('HomeControllerBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  void changeTabMovie(MoviePageType moviePageType) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.changeTabMovie');
    try {
      return super.changeTabMovie(moviePageType);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
