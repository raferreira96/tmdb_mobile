part of '../movie_page.dart';

class MovieDetails extends StatelessWidget {
  final MovieDetailsModel movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String year = DateTime.parse(movie.releaseDate).year.toString();
    initializeDateFormatting();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Center(
            child: Column(
          children: [
            Text('${movie.title} ($year)',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.primaryColor),
                textAlign: TextAlign.center),
            SizedBox(
              height: 60,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  itemCount: movie.genres.length,
                  itemBuilder: (context, index) {
                    final genre = movie.genres[index];
                    return _GenreItemWidget(genre);
                  },
                ),
              ),
            )
          ],
        )),
      ),
      Divider(
        thickness: 1,
        color: context.primaryColor,
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Sinopse',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor),
            textAlign: TextAlign.center),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          movie.overview, style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Título Original',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor),
            textAlign: TextAlign.center),
      ),
      Text(movie.originalTitle, style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Idioma Original',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor),
            textAlign: TextAlign.center),
      ),
      Text(movie.originalLanguage, style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Data de Lançamento',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor),
            textAlign: TextAlign.center),
      ),
      Text(
          DateFormat.yMMMMd('pt_BR').format(DateTime.parse(movie.releaseDate)), style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Avaliações dos Usuários',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor),
            textAlign: TextAlign.center),
      ),
      const SizedBox(height: 15),
      CircularPercentIndicator(
          radius: 60,
          lineWidth: 15,
          percent: movie.voteAverage / 10,
          center: Text(movie.voteAverage.toStringAsFixed(1),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.primaryColor)),
          progressColor: movie.voteAverage >= 7 ? Colors.green : movie.voteAverage < 7 && movie.voteAverage >= 4 ? Colors.yellow : Colors.red),
      const SizedBox(height: 15),
    ]);
  }
}

class _GenreItemWidget extends StatelessWidget {
  final GenreModel genre;
  const _GenreItemWidget(this.genre);

  @override
  Widget build(BuildContext context) {
    var lenght = genre.name.length;
    return Row(
      children: [
        Container(
          width: 120,//(double.parse('${genre.name.length}') * 15),
          height: 25,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: context.primaryColor),
            borderRadius: BorderRadius.circular(100),
            color: context.primaryColor
          ),
          child: Text(genre.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: lenght > 14 ? 14 : 18, fontWeight: FontWeight.bold))
          ),
      ],
    );
  }
}
