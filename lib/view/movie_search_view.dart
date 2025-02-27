import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/movie_search_controller.dart';
import 'package:movieapp/helper/utils.dart';
import 'package:movieapp/routes/app_pages.dart';

class MovieSearchView extends GetView<MovieSearchController> {
  const MovieSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie App',
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: Obx(
                    () => controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              controller.clearSearch();
                            },
                          )
                        : const SizedBox(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xffD0D5DD).withOpacity(
                        0.1,
                      ),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffD0D5DD),
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  if (value.length > 2) {
                    controller.onSearchChanged(value);
                  } else {
                    controller.searchResults.clear();
                  }
                },
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.searchQuery.value.length > 2 &&
                      controller.searchResults.isEmpty) {
                    return const Center(
                      child: Text(
                        "No data found",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = controller.searchResults[index];
                        return ListTile(
                          title: Text(movie.title),
                          subtitle: Text(
                            Utils.formatDate(
                              movie.releaseDate,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                          ),
                          onTap: () {
                            Get.toNamed(
                              AppPages.movieDetailPage,
                              arguments: movie.id,
                            );
                          },
                        );
                      },
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
