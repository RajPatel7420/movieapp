// search_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/model/movie_list.dart';
import 'package:movieapp/model/custom_movie_model.dart';
import 'package:movieapp/services/api_services.dart';
import 'package:movieapp/services/network_service.dart';
import 'package:http/http.dart' as http;

class MovieSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  RxList<CustomMovieModel> searchResults = <CustomMovieModel>[].obs;
  Rxn<MovieList> apiMovieList = Rxn<MovieList>();

  @override
  void onInit() async {
    super.onInit();
  }

  Map<String, String> _getHeaders() {
    return {
      'Authorization': 'Bearer ${ApiService.bearerToken}',
      'accept': 'application/json'
    };
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.length > 2) {
      searchMovieList(query);
    } else {
      searchResults.clear();
    }
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    searchResults.clear();
  }

  Future<void> searchMovieList(String movieName) async {
    if (!await NetworkService.hasInternet()) {
      Get.snackbar(
        "No Internet Connection",
        "Please check your internet connection and try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(
            '${ApiService.apiUrl}search/movie?query=$movieName&include_adult=false&language=en-US&page=1'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        apiMovieList.value = MovieList.fromJson(data);
        final apiMovieListData = apiMovieList.value?.results;

        searchResults.clear();

        if (apiMovieListData != null && apiMovieListData.isNotEmpty) {
          for (var data in apiMovieListData) {
            searchResults.add(
              CustomMovieModel(
                id: data.id ?? 0,
                title: data.title ?? '',
                overview: data.overview ?? '',
                posterPath: data.posterPath ?? '',
                releaseDate: data.releaseDate ?? '',
              ),
            );
          }
        }
      } else {
        Get.snackbar(
          "Error ${response.statusCode}",
          "Failed to fetch search results. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong while searching. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint("searchMovieList Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
