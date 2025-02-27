import 'dart:convert';
import 'package:get/get.dart';
import 'package:movieapp/model/custom_movie_detail.dart';
import 'package:movieapp/model/movie_detail.dart';
import 'package:movieapp/services/api_services.dart';
import 'package:movieapp/services/network_service.dart';
import 'package:http/http.dart' as http;

class MovieDetailController extends GetxController {
  final RxBool isLoading = false.obs;
  Rxn<MovieDetailModel> movieDetailsModel = Rxn<MovieDetailModel>();
  Rxn<CustomMovieDetailsModel> movieDetailsData =
      Rxn<CustomMovieDetailsModel>();
  dynamic arguments;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      arguments = Get.arguments;
      Future.delayed(Duration.zero, () async {
        await getMovieDetails(
          arguments.toString(),
        );
      });
    }
    super.onInit();
  }

  Map<String, String> _getHeaders() {
    return {
      'Authorization': 'Bearer ${ApiService.bearerToken}',
      'accept': 'application/json'
    };
  }

  Future<void> getMovieDetails(
    String movieId,
  ) async {
    if (!await NetworkService.hasInternet()) {
      return;
    }
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('${ApiService.apiUrl}/movie/$movieId?language=en-US'),
      headers: _getHeaders(),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      movieDetailsModel.value = MovieDetailModel.fromJson(data);

      if (movieDetailsModel.value != null) {
        movieDetailsData.value = CustomMovieDetailsModel(
          id: movieDetailsModel.value?.id ?? 0,
          title: movieDetailsModel.value?.title ?? '',
          overview: movieDetailsModel.value?.overview ?? '',
          posterPath: movieDetailsModel.value?.posterPath?.isNotEmpty == true
              ? movieDetailsModel.value?.posterPath ?? ''
              : '', // Avoid passing null
          releaseDate: movieDetailsModel.value?.releaseDate ?? '',
          genre: movieDetailsModel.value?.genres?.isNotEmpty == true
              ? movieDetailsModel.value?.genres?.first.name ?? ''
              : '',
          averageVote: movieDetailsModel.value?.voteAverage ?? 0.0,
          movieDuration: movieDetailsModel.value?.runtime != null
              ? "${movieDetailsModel.value?.runtime} minutes"
              : '',
          movieProductionCompanies: movieDetailsModel.value?.productionCompanies
              ?.map((company) => company.name)
              .whereType<String>() // Filters out null values
              .toList() ??
              [],

          movieProductionCountries: movieDetailsModel.value?.productionCountries
              ?.map((country) => country.name)
              .whereType<String>() // Filters out null values
              .toList() ??
              [],
        );
      }
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
