// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:korea_to_english_translator/views/constants/routes.dart';
import 'package:korea_to_english_translator/views/pages/favorite/favorite.dart';
import 'package:korea_to_english_translator/views/pages/home/home.dart';
import 'package:korea_to_english_translator/views/pages/splash/splash.dart';

class AppRoute {
  static List<GetPage<dynamic>> routes() {
    return [
      GetPage(name: initialRoute, page: () => const SplashPage()),
      GetPage(name: homeRoute, page: () => const HomePage()),
      GetPage(name: favoriteRoute, page: () => const FavoritePage()),
    ];
  }
}
