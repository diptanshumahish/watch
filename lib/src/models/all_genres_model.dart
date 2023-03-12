class AllGenres {
  final List<Genre> genres;

  AllGenres({required this.genres});

  factory AllGenres.fromJson(Map<String, dynamic> json) => AllGenres(
        genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
      );
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']);
}
