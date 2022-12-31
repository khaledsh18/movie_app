import 'package:movie_app/entities/movie_details.dart';

import 'movie.dart';

class MovieModal {
  Movie movie;
  MovieDetails details;

  MovieModal({required this.movie, required this.details});

  static Map<String, Object?> toMap(MovieModal movieModal) {
    return {
      'movie': Movie.toMap(movieModal.movie),
      'details': MovieDetails.toMap(movieModal.details),
    };
  }

  static MovieModal fromJson(json) => MovieModal(
        movie: Movie.fromJson(json['movie']),
        details: MovieDetails.fromJson(json['details']),
      );
}
