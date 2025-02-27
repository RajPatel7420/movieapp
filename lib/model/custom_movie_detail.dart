class CustomMovieDetailsModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String genre;
  final double averageVote;
  final String movieDuration;
  final List<String> movieProductionCompanies;
  final List<String> movieProductionCountries;

  CustomMovieDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.genre,
    required this.averageVote,
    required this.movieDuration,
    required this.movieProductionCompanies,
    required this.movieProductionCountries,
  });

  factory CustomMovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomMovieDetailsModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      genre: json['genre'] ?? '',
      averageVote: json['average_vote'] ?? '',
      movieDuration: json['movie_duration'] ?? '',
      movieProductionCompanies: (json['production_companies'] as List?)
          ?.map((company) => company['name'] as String?)
          .whereType<String>() // Filters out null values
          .toList() ??
          [],

      movieProductionCountries: (json['production_countries'] as List?)
          ?.map((country) => country['name'] as String?)
          .whereType<String>() // Filters out null values
          .toList() ??
          [],
    );
  }
}