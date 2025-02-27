import 'package:flutter/material.dart';
import 'package:movieapp/model/custom_movie_model.dart';
import 'package:movieapp/widget/movie_card.dart';

class MovieCategorySection extends StatelessWidget {
  final String title;
  final List<CustomMovieModel> movies;
  final bool isTextRequired;
  final double posterHeight;
  final double posterWidth;

  const MovieCategorySection({
    Key? key,
    required this.title,
    required this.movies,
    required this.isTextRequired,
    this.posterHeight = 150,
    this.posterWidth = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicHeight = posterHeight + (isTextRequired ? 40 : 20);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: dynamicHeight,
          child: movies.isEmpty
              ? const Center(
                  child: Text(
                    'No movies available',
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: MovieCard(
                        movie: movies[index],
                        isTextRequired: isTextRequired,
                        posterHeight: posterHeight,
                        posterWidth: posterWidth,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
