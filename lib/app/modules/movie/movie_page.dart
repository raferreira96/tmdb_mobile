import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tmdb/app/core/ui/extensions/theme_extension.dart';
import 'package:tmdb/app/models/genre_model.dart';
import 'package:tmdb/app/models/movie_details_model.dart';

part 'widgets/movie_details.dart';

class MoviePage extends StatefulWidget {
  final MovieDetailsModel movie;
  const MoviePage({super.key, required this.movie});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late ScrollController _scrollController;
  bool sliverCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 &&
          !_scrollController.position.outOfRange) {
            setState(() {
              sliverCollapsed = true;
            });
      } else if (_scrollController.offset <= 100 &&
          !_scrollController.position.outOfRange) {
        setState(() {
              sliverCollapsed = false;
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String year = DateTime.parse(widget.movie.releaseDate).year.toString();
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
        expandedHeight: 500,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.fadeTitle
          ],
          background: Image.network(
              'https://www.themoviedb.org/t/p/original/${widget.movie.posterPath}',
              fit: BoxFit.fitWidth,
              errorBuilder: ((context, error, stackTrace) =>
                  const SizedBox.shrink())),
        ),
        title:
            Visibility(visible: sliverCollapsed, child: Text('${widget.movie.title} ($year)', textAlign: TextAlign.center)),
      ),
      SliverToBoxAdapter(
        child: MovieDetails(movie: widget.movie),
      ),
    ]));
  }
}
