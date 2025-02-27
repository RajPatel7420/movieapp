import 'package:get/get.dart';
import 'package:movieapp/binding/home_binding.dart';
import 'package:movieapp/binding/movie_detail_binding.dart';
import 'package:movieapp/binding/movie_search_binding.dart';
import 'package:movieapp/routes/app_pages.dart';
import 'package:movieapp/view/home_view.dart';
import 'package:movieapp/view/movie_detail_view.dart';
import 'package:movieapp/widget/bottom_navigation_bar/bottom_navigation.dart';
import 'package:movieapp/widget/bottom_navigation_bar/bottom_navigation_binding.dart';

import '../view/movie_search_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: AppPages.initial,
      page: () => const BottomNavigationPage(),
      transition: Transition.fadeIn,
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: AppPages.homePage,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppPages.searchPage,
      page: () => const MovieSearchView(),
      transition: Transition.fadeIn,
      binding: MovieSearchBinding(),
    ),
    GetPage(
      name: AppPages.movieDetailPage,
      page: () => const MovieDetailView(),
      transition: Transition.fadeIn,
      binding: MovieDetailBinding(),
    ),
  ];
}
