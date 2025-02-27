import 'dart:convert';
import 'package:get/get.dart';
import 'package:movieapp/model/custom_movie_model.dart';
import 'package:movieapp/model/movie_list.dart';
import 'package:movieapp/services/api_services.dart';
import 'package:movieapp/services/network_service.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxList<CustomMovieModel> nowPlayingMovies = <CustomMovieModel>[].obs;
  RxList<CustomMovieModel> upcomingMovies = <CustomMovieModel>[].obs;
  RxList<CustomMovieModel> topRatedMovies = <CustomMovieModel>[].obs;
  RxList<CustomMovieModel> searchResults = <CustomMovieModel>[].obs;
  Rxn<MovieList> apiMovieList = Rxn<MovieList>();
  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadAllMovies();
  }

  Map<String, String> _getHeaders() {
    return {
      'Authorization': 'Bearer ${ApiService.bearerToken}',
      'accept': 'application/json'
    };
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadAllMovies() async {
    await fetchMovies(
      'now_playing',
      nowPlayingMovies,
    );
    await fetchMovies(
      'upcoming',
      upcomingMovies,
    );
    await fetchMovies(
      'top_rated',
      topRatedMovies,
    );
  }

  Future<void> fetchMovies(
    String category,
    RxList<CustomMovieModel> movieList,
  ) async {
    if (!await NetworkService.hasInternet()) {
      return;
    }
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('${ApiService.apiUrl}/movie/$category?include_adult=false?language=en-US&page=2'),
      headers: _getHeaders(),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      apiMovieList.value = MovieList.fromJson(data);
      final apiMovieListData = apiMovieList.value?.results;

      // movieList.clear();
      if (apiMovieListData != null && apiMovieListData.isNotEmpty) {
        for (int i = 0; i < apiMovieListData.length; i++) {
          final data = apiMovieListData[i];
          movieList.add(
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
    }
    isLoading.value = false;
  }
}
