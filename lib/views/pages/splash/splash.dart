// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:korea_to_english_translator/views/constants/assets.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korea_to_english_translator/views/constants/routes.dart';
import 'package:korea_to_english_translator/views/constants/strings.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 4), () {
      Get.offNamed(homeRoute);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: TweenAnimationBuilder<Color?>(
          tween: ColorTween(begin: Colors.blue.withOpacity(0.3), end: bgColor),
          duration: const Duration(seconds: 2),
          builder: (context, color, child) {
            return Container(
              height: size.height,
              width: size.width,
              color: color,
              child: Stack(
                children: [
                  allelements(size),
                  GlassmorphicContainer(
                      width: size.width,
                      height: size.height,
                      borderRadius: 20,
                      blur: 0.2,
                      alignment: Alignment.bottomCenter,
                      border: 0,
                      linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 40, 21, 255).withOpacity(0.1),
                            Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.05),
                          ],
                          stops: const [
                            0.1,
                            1,
                          ]),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 98, 255, 137)
                              .withOpacity(0.5),
                          const Color((0xFF9CFA9B)).withOpacity(0.5),
                        ],
                      ),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appName,
                            style: GoogleFonts.passeroOne(
                                fontSize: 30.0, color: titleColor),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            appTitle,
                            style: GoogleFonts.bubblerOne(
                                fontSize: 16.0, color: Colors.black),
                          ),
                        ],
                      ))),
                ],
              ),
            );
          }),
    );
  }

  Stack allelements(Size size) {
    return Stack(
      children: [
        animationWidget(
            asset: bubbleMessage,
            beging: 0.0,
            end: 1.0,
            h: 100.0,
            w: 100.0,
            t: 70.0,
            l: 10.0,
            animvalue: 20,
            isMinus: true),
        animationWidget(
            asset: circleMessage,
            beging: 0.0,
            end: 1.0,
            t: 50.0,
            l: size.width / 2.4,
            animvalue: 10,
            isMinus: false),
        animationWidget(
            asset: squareMessage,
            beging: 0.0,
            end: 1.0,
            t: 70.0,
            w: 55,
            r: 30.0,
            animvalue: 10,
            isMinus: false),
        animationWidget(
            asset: randoMessage,
            beging: 0.0,
            end: 1.0,
            t: 140.0,
            l: size.width / 3,
            animvalue: 10,
            isMinus: true),
        animationWidget(
            asset: roundMessage,
            beging: 0.0,
            end: 1.0,
            t: 140.0,
            w: 60,
            r: size.width / 5.5,
            animvalue: 10,
            isMinus: false),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            people,
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Positioned animationWidget(
      {double? l,
      double? r,
      double? t,
      double? b,
      required String asset,
      double? h,
      double? w,
      required double beging,
      required double end,
      required double animvalue,
      required bool isMinus}) {
    return Positioned(
      left: l,
      top: t,
      bottom: b,
      right: r,
      child: TweenAnimationBuilder<double?>(
          tween: Tween(begin: beging, end: end),
          duration: const Duration(seconds: 3),
          child: Image.asset(
            asset,
            height: h ?? 65.0,
            width: w ?? 65.0,
          ),
          builder: (context, value, child) {
            if (isMinus == true) {
              return Transform.translate(
                offset: Offset(
                  -value! * animvalue,
                  0.0,
                ),
                child: child,
              );
            } else {
              return Transform.translate(
                offset: Offset(
                  value! * animvalue,
                  0.0,
                ),
                child: child,
              );
            }
          }),
    );
  }
}

animationTextWidget(
    {required String tex,
    required double beging,
    required double end,
    required double animvalue,
    required bool isMinus}) {
  return TweenAnimationBuilder<double?>(
      tween: Tween(begin: beging, end: end),
      duration: const Duration(seconds: 3),
      child: Text(
        tex,
        style: GoogleFonts.openSans(
            fontSize: 18.0, color: titleColor, fontWeight: FontWeight.w500),
      ),
      builder: (context, value, child) {
        if (isMinus == true) {
          return Transform.translate(
            offset: Offset(
              -value! * animvalue,
              0.0,
            ),
            child: child,
          );
        } else {
          return Transform.translate(
            offset: Offset(
              value! * animvalue,
              0.0,
            ),
            child: child,
          );
        }
      });
}
