// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korea_to_english_translator/views/constants/assets.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                image: AssetImage(
                  randomBg,
                ),
                fit: BoxFit.cover)),
        child: GlassmorphicContainer(
            width: size.width,
            height: size.height,
            borderRadius: 0,
            blur: 5,
            alignment: Alignment.topCenter,
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
                Color.fromARGB(255, 50, 84, 255).withOpacity(0.5),
                Color.fromARGB(255, 255, 18, 117).withOpacity(0.5),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TypeView(size: size),
                  ResultView(size: size),
                ],
              ),
            )),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: const Icon(
        Icons.menu_outlined,
        color: titleColor,
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "English",
            style: GoogleFonts.openSans(
                fontSize: 18.0, color: titleColor, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 20.0,
          ),
          // CircleAvatar(
          //   backgroundColor: whitColor,
          // child: IconButton(
          //   splashRadius: 25.0,
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.compare_arrows_outlined,
          //     color: titleColor,
          //   ),
          // ),
          // ),
          GlassmorphicContainer(
              shape: BoxShape.circle,
              width: 40,
              height: 40,
              borderRadius: 20,
              blur: 10,
              alignment: Alignment.bottomCenter,
              border: 1,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 255, 0, 0).withOpacity(0.1),
                    Color.fromARGB(255, 44, 193, 243).withOpacity(0.05),
                  ],
                  stops: const [
                    0.1,
                    1,
                  ]),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.5),
                  Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
              child: IconButton(
                splashColor: bgColorPro,
                splashRadius: 25.0,
                onPressed: () {},
                icon: const Icon(
                  Icons.compare_arrows_outlined,
                  color: whitColor,
                ),
              )),
          const SizedBox(
            width: 18.0,
          ),
          Text(
            "Korea",
            style: GoogleFonts.openSans(
                fontSize: 20.0, color: titleColor, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }
}

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
        width: size.width,
        height: size.height * 0.3,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.bottomCenter,
        border: 1,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.1),
              Color(0xFFFFFFFF).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.5),
            Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 14.0),
              child: Text(
                "Sgong HST Pgarlo",
                style: GoogleFonts.openSans(color: blackColor),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleButton(
                    icon: Icons.favorite_border_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.copy_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.share_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.play_arrow_outlined,
                    color: bgColor,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class TypeView extends StatelessWidget {
  const TypeView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        margin: const EdgeInsets.only(top: 100.0, left: 15.0, right: 15.0),
        width: size.width,
        height: size.height * 0.3,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.bottomCenter,
        border: 1,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.1),
              Color(0xFFFFFFFF).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.5),
            Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        child: Column(
          children: [
            Expanded(
                child: TextField(
              style: GoogleFonts.openSans(color: titleColor),
              maxLines: 12,
              cursorColor: bgColor,
              decoration: InputDecoration(
                isCollapsed: true,
                focusColor: bgColor,
                hoverColor: bgColor,
                iconColor: bgColor,
                labelStyle: GoogleFonts.openSans(color: bgColor),
                isDense: true,
                fillColor: bgColor,
                filled: false,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                border: InputBorder.none,
                hintText: "Type here...",
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleButton(
                    icon: Icons.save_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.camera_alt_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.mic_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.draw_outlined,
                    color: bgColor,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.close,
                    color: redColor,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        shape: BoxShape.circle,
        width: 43,
        height: 43,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.bottomCenter,
        border: 1,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0).withOpacity(0.1),
              Color.fromARGB(255, 44, 193, 243).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.5),
            Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        child: IconButton(
          splashColor: bgColorPro,
          splashRadius: 25.0,
          onPressed: () {},
          icon: Icon(
            icon,
            color: color,
          ),
        ));
  }
}
