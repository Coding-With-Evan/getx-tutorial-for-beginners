import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_bindings.dart';
import 'app_routes.dart';
import 'pages/details_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const GetXDemoApp());
}

class GetXDemoApp extends StatelessWidget {
  const GetXDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Tutorial',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(name: AppRoutes.home, page: () => const HomePage()),
        GetPage(name: AppRoutes.details, page: () => const DetailsPage()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
