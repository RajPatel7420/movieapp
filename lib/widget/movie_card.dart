import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/model/custom_movie_model.dart';
import 'package:movieapp/routes/app_pages.dart';

class MovieCard extends StatelessWidget {
  final CustomMovieModel movie;
  final bool isTextRequired;
  final double posterHeight;
  final double posterWidth;

  const MovieCard({
    Key? key,
    required this.movie,
    required this.isTextRequired,
    this.posterHeight = 150,
    this.posterWidth = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppPages.movieDetailPage,
          arguments: movie.id,
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://image.tmdb.org/t/p/original${movie.posterPath}",
              height: posterHeight,
              width: posterWidth,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 5),
          isTextRequired == true
              ? Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
