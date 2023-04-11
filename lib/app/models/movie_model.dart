// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  
  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      title: map['title'] as String,
      posterPath: map['poster_path'] as String,
      releaseDate: map['release_date'] as String,
      voteAverage: map['vote_average'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
