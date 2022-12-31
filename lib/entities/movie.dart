class Movie {
  final String title;
  final String? posterUrl;
  final String? backdrop;
  final int id;

  Movie({
    required this.title,
    required this.posterUrl,
    required this.backdrop,
    required this.id,
  });

  static Movie fromJson(json) =>
      Movie(
        title: json['title'],
        posterUrl: json['poster_path'],
        backdrop: json['backdrop_path'],
        id: json['id'],
      );

  static List<Movie> fromJsonList(List<dynamic> list) {
    List<Movie> movies = [];
    for (dynamic element in list) {
      movies.add(fromJson(element));
    }
    return movies;
  }
  static Map<String,Object?> toMap(Movie movie) =>
      {
        'title': movie.title,
        'poster_path': movie.posterUrl,
        'backdrop_path': movie.backdrop,
        'id': movie.id,
      };
}
