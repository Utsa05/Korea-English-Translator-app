// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:korea_to_english_translator/app_route.dart';
import 'package:korea_to_english_translator/views/constants/routes.dart';
import 'package:korea_to_english_translator/views/constants/strings.dart';
import 'package:korea_to_english_translator/views/pages/favorite/favorite.dart';
import 'package:korea_to_english_translator/views/pages/splash/splash.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 0.0, backgroundColor: Colors.transparent)),
      getPages: AppRoute.routes(),

      initialRoute: initialRoute,
    );
  }
}
