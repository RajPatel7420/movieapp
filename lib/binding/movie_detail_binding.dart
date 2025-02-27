import 'package:get/get.dart';
import 'package:movieapp/controllers/movie_detail_controller.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailController>(() => MovieDetailController());
  }
}