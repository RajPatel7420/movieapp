/// bindings/home_binding.dart
import 'package:get/get.dart';
import 'package:movieapp/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}