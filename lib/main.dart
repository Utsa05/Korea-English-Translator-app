import 'package:flutter/material.dart';
import 'package:korea_to_english_translator/views/constants/strings.dart';
import 'package:korea_to_english_translator/views/pages/home/home.dart';
import 'package:korea_to_english_translator/views/pages/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
