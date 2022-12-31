class Cast {
  final String name;
  final String? photo;
  final String character;

  Cast({
    required this.name,
    required this.photo,
    required this.character,
  });
  static Cast fromJson(json) => Cast(
        name: json['name'],
        photo: json['profile_path'],
        character: json['character'],
      );

  static List<Cast> fromJsonList(List<dynamic> list) {
    List<Cast> casts = [];
    for (dynamic element in list) {
      casts.add(fromJson(element));
    }
    return casts;
  }
}
