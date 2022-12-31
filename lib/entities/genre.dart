class Genre {
  final String name;
  final int id;

  Genre({required this.name, required this.id});

  static Genre fromJson(json) => Genre(
        id: json['id'],
        name: json['name'],
      );

  static List<Genre> fromJsonList(List<dynamic> list) {
    List<Genre> genres = [];
    for (dynamic element in list) {
      genres.add(fromJson(element));
    }
    return genres;
  }

  static Map<String, Object?> toMap(Genre genre) => {
        'name': genre.name,
        'id': genre.id,
      };

  static List<Map<String, Object?>> toMapList(List<Genre> genres) {
    if (genres == null) {
      return [];
    }
    final List<Map<String, Object?>> genresMapList = [];

    for (Genre genre in genres) {
      genresMapList.add(toMap(genre));
    }
    return genresMapList;
  }
}
