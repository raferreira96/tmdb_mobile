import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/modules/movie/movie_page.dart';

class MovieModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: ((context, args) => MoviePage(movie: args.data)))
  ];
}