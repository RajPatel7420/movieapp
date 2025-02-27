import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/movie_detail_controller.dart';
import 'package:movieapp/helper/utils.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  const MovieDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Movie Details',
          ),
          // backgroundColor: const Color(0xff16275A),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff16275A), Color(0xff1E3377)],
                tileMode: TileMode.mirror,
              ),
            ),
          ),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  controller.movieDetailsData.value?.posterPath.isNotEmpty ==
                          true
                      ? "https://image.tmdb.org/t/p/original${controller.movieDetailsData.value?.posterPath}"
                      : "https://placehold.co/500x250?text=No+Image",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/placeholder.jpg',
                    // Ensure you have a placeholder image
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.movieDetailsData.value?.title ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${controller.movieDetailsData.value?.genre ?? ''} · ${Utils.formatDate(controller.movieDetailsData.value?.releaseDate ?? '')} · ${controller.movieDetailsData.value?.movieDuration ?? ''}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        controller.movieDetailsData.value?.overview ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${controller.movieDetailsData.value?.averageVote ?? ''}/10",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildDetailSection(
                        "Production Companies",
                        controller.movieDetailsData.value
                                ?.movieProductionCompanies ??
                            [],
                      ),
                      _buildDetailSection(
                        "Production Countries",
                        controller.movieDetailsData.value
                                ?.movieProductionCountries ??
                            [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                ...items.map(
                  (item) => Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
