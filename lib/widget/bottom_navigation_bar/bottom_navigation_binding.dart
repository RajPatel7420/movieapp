import 'package:get/get.dart';
import 'package:movieapp/controllers/home_controller.dart';
import 'package:movieapp/controllers/movie_search_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MovieSearchController());

  }
}
