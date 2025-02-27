class CustomMovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  CustomMovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  factory CustomMovieModel.fromJson(Map<String, dynamic> json) {
    return CustomMovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
    );
  }
}