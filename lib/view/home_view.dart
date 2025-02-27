import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/home_controller.dart';
import 'package:movieapp/widget/movie_category_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie App',
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
      body: SafeArea(
        top: false,
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MovieCategorySection(
                        title: 'Now Playing',
                        movies: controller.nowPlayingMovies,
                        isTextRequired: false,
                        posterHeight: 230,
                        posterWidth: 200,
                      ),
                      MovieCategorySection(
                        title: 'Upcoming',
                        movies: controller.upcomingMovies,
                        isTextRequired: true,
                        posterHeight: 150,
                        posterWidth: 200,
                      ),
                      MovieCategorySection(
                        title: 'Top Rated',
                        movies: controller.topRatedMovies,
                        isTextRequired: true,
                        posterHeight: 150,
                        posterWidth: 200,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
