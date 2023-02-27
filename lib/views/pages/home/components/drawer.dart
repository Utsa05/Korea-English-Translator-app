// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korea_to_english_translator/views/constants/assets.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';
import 'package:korea_to_english_translator/views/constants/routes.dart';
import 'package:korea_to_english_translator/views/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    urlLaunce(String uri) async {
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    return Container(
      width: 270.0,
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.5,
              image: AssetImage(
                randomBg,
              ),
              fit: BoxFit.cover)),
      child: GlassmorphicContainer(
        width: size.width,
        height: size.height,
        borderRadius: 0,
        blur: 5,
        alignment: Alignment.topLeft,
        border: 0,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.1),
              const Color(0xFFFFFFFF).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 50, 84, 255).withOpacity(0.5),
            const Color.fromARGB(255, 255, 18, 117).withOpacity(0.5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(size: size),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassmorphicContainer(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    width: size.width,
                    height: 50.0,
                    borderRadius: 10,
                    blur: 10,
                    alignment: Alignment.topLeft,
                    border: 0,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.5),
                        const Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(favoriteRoute);
                      },
                      tileColor: bgColor,
                      leading: const Icon(
                        Icons.favorite,
                        color: bgColorPro,
                      ),
                      title: Text(
                        "Favorite",
                        style: GoogleFonts.openSans(
                            fontSize: 18.0, color: bgColorPro),
                      ),
                    ),
                  ),
                  GlassmorphicContainer(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    width: size.width,
                    height: 50.0,
                    borderRadius: 10,
                    blur: 10,
                    alignment: Alignment.topLeft,
                    border: 0,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.5),
                        const Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        urlLaunce("https://textsaver.flap.tv/lists/5h25");
                      },
                      tileColor: bgColorPro,
                      leading: const Icon(
                        Icons.privacy_tip,
                        color: bgColorPro,
                      ),
                      title: Text(
                        "Privacy Policy",
                        style: GoogleFonts.openSans(
                            fontSize: 18.0, color: bgColorPro),
                      ),
                    ),
                  ),
                  GlassmorphicContainer(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    width: size.width,
                    height: 50.0,
                    borderRadius: 10,
                    blur: 10,
                    alignment: Alignment.topLeft,
                    border: 0,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.5),
                        const Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        urlLaunce(
                            "https://play.google.com/store/apps/developer?id=Null-IT");
                      },
                      tileColor: bgColorPro,
                      leading: const Icon(
                        Icons.more_horiz,
                        color: bgColorPro,
                      ),
                      title: Text(
                        "More Apps",
                        style: GoogleFonts.openSans(
                            fontSize: 18.0, color: bgColorPro),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      margin: const EdgeInsets.only(bottom: 5.0),
      padding: const EdgeInsets.only(top: 100.0),
      width: size.width,
      height: 220.0,
      borderRadius: 0,
      blur: 10,
      alignment: Alignment.topLeft,
      border: 0,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.1),
            const Color(0xFFFFFFFF).withOpacity(0.05),
          ],
          stops: const [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.5),
          const Color((0xFFFFFFFF)).withOpacity(0.5),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Image.asset(
              'assets/images/conversation.png',
              height: 80.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              appName,
              style: GoogleFonts.passeroOne(fontSize: 30.0, color: titleColor),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              appTitle,
              style:
                  GoogleFonts.bubblerOne(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
