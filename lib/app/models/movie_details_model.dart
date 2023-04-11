import 'dart:convert';

import 'package:tmdb/app/models/genre_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieDetailsModel {
  int id;
  String title;
  String originalTitle;
  String overview;
  String tagline;
  String originalLanguage;
  String posterPath;
  String releaseDate;
  double voteAverage;
  List<GenreModel> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.tagline,
    required this.originalLanguage,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'originalTitle': originalTitle,
      'overview': overview,
      'tagline': tagline,
      'originalLanguage': originalLanguage,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'genres': genres.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailsModel(
      id: map['id'] as int,
      title: map['title'] as String,
      originalTitle: map['original_title'] as String,
      overview: map['overview'] as String,
      tagline: map['tagline'] as String,
      originalLanguage: map['original_language'] as String,
      posterPath: map['poster_path'] as String,
      releaseDate: map['release_date'] as String,
      voteAverage: map['vote_average'].toDouble() as double,
      genres: List<GenreModel>.from((map['genres'] as List<dynamic>).map<GenreModel>((x) => GenreModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailsModel.fromJson(String source) =>
      MovieDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
