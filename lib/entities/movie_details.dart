import 'genre.dart';

class MovieDetails {
  final int length;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final List<Genre> genres;

  MovieDetails({
    required this.length,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
  });

  static MovieDetails fromJson(json) => MovieDetails(
        overview: json['overview'],
        releaseDate: json['release_date'],
        voteAverage: double.parse('${json['vote_average']}'),
        length: json['runtime'],
        genres: Genre.fromJsonList(json['genres']),
      );

  static List<MovieDetails> fromJsonList(List<dynamic> list) {
    List<MovieDetails> movies = [];
    for (dynamic element in list) {
      movies.add(fromJson(element));
    }
    return movies;
  }

  static Map<String,Object?> toMap(MovieDetails details) =>
      {
        'runtime': details.length,
        'overview': details.overview,
        'release_date': details.releaseDate,
        'vote_average': details.voteAverage,
        'genres': Genre.toMapList(details.genres),
      };
}
