/// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/routes/app_pages.dart';
import 'package:movieapp/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      initialRoute: AppPages.initial,
      getPages: AppRoutes.routes,
    );
  }
}
