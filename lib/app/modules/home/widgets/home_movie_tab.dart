// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../home_page.dart';

class _HomeMovieTab extends StatelessWidget {
  final HomeController homeController;

  const _HomeMovieTab({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _HomeTabHeader(homeController: homeController),
      Expanded(
        child: Observer(builder: (_) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: homeController.moviePageTypeSelected == MoviePageType.list
                  ? _HomeMovieList(homeController)
                  : _HomeMovieGrid(homeController));
        }),
      )
    ]);
  }
}

class _HomeTabHeader extends StatelessWidget {
  final HomeController homeController;
  const _HomeTabHeader({
    required this.homeController,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(children: [
        const Text('Visualização'),
        const Spacer(),
        InkWell(
            onTap: () => homeController.changeTabMovie(MoviePageType.list),
            child: const Icon(Icons.view_headline)),
        InkWell(
            onTap: () => homeController.changeTabMovie(MoviePageType.grid),
            child: const Icon(Icons.view_comfy)),
      ]),
    );
  }
}

class _HomeMovieList extends StatelessWidget {
  final HomeController _homeController;
  const _HomeMovieList(this._homeController);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: _homeController.listMovies.length,
                    (context, index) {
              final movie = _homeController.listMovies[index];
              return _HomeMovieListItemWidget(
                  movie: movie, homeController: _homeController);
            }));
          },
        ),
      ]
    );
  }
}

class _HomeMovieGrid extends StatelessWidget {
  final HomeController controller;
  const _HomeMovieGrid(this.controller);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(builder: (_) {
          return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  childCount: controller.listMovies.length, (context, index) {
                final movie = controller.listMovies[index];
                return _HomeMovieCardItemWidget(movie, controller);
              }),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 2,
              ));
        })
      ],
    );
  }
}

class _HomeMovieCardItemWidget extends StatelessWidget {
  final MovieModel movie;
  final HomeController homeController;
  const _HomeMovieCardItemWidget(this.movie, this.homeController);

  @override
  Widget build(BuildContext context) {
    String year = DateTime.parse(movie.releaseDate).year.toString();
    double rating = movie.voteAverage;

    return InkWell(
      onTap: () async {
        var model = await homeController.getMovie(movie.id);
        Modular.to.pushNamed('/movie/', arguments: model);
      },
      child: Stack(children: [
          Card(
            margin:
                const EdgeInsets.all(10),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://www.themoviedb.org/t/p/w220_and_h330_face${movie.posterPath}'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 290, right: 10, bottom: 10, left: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${movie.title} ($year)',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          //overflow: TextOverflow.ellipsis
                          ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        CircularPercentIndicator(
                            radius: 18,
                            lineWidth: 5,
                            percent: rating / 10,
                            center: Text(rating.toString()),
                            progressColor:
                                rating >= 7 ? Colors.green : rating < 7 && rating >= 4 ? Colors.yellow : Colors.red)
                      ]),
                    ]),
              ),
            ),
          ),
      ]),
    );
  }
}

class _HomeMovieListItemWidget extends StatelessWidget {
  final MovieModel movie;
  final HomeController homeController;

  const _HomeMovieListItemWidget(
      {required this.movie, required this.homeController});

  @override
  Widget build(BuildContext context) {
    String year = DateTime.parse(movie.releaseDate).year.toString();
    double rating = movie.voteAverage;

    return InkWell(
      onTap: () async {
        var model = await homeController.getMovie(movie.id);
        Modular.to.pushNamed('/movie/', arguments: model);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.only(left: 30),
              width: 1.sw,
              height: 80.h,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${movie.title} ($year)',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 10),
                            Row(children: [
                              CircularPercentIndicator(
                                  radius: 18,
                                  lineWidth: 5,
                                  percent: rating / 10,
                                  center: Text(rating.toString()),
                                  progressColor: rating >= 7 ? Colors.green : rating < 7 && rating >= 4 ? Colors.yellow : Colors.red),
                            ])
                          ])),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: context.primaryColor,
                    maxRadius: 15,
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                )
              ])),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 1),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[100]!, width: 5),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.themoviedb.org/t/p/w220_and_h330_face${movie.posterPath}'),
                      fit: BoxFit.contain)),
            ),
          )
        ]),
      ),
    );
  }
}
