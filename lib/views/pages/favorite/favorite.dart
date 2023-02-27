// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:korea_to_english_translator/controller/home.dart';
import 'package:korea_to_english_translator/views/constants/assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';
import 'package:get/get.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scrollcontroller = ScrollController();
    final HomeController homeController = Get.put(HomeController());

    // List<dynamic> list = [
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    //   {
    //     "sendLang": "Where is the rest room",
    //     "resultLang": "Lgarie ugeiw Kgog Ego Yne"
    //   },
    //   {
    //     "sendLang": "Can you tell me how can i go to Korean Goverment Varsity",
    //     "resultLang":
    //         "Ngeiw Rgerjer Kuregew Nerweew Kijdsf Ghere Khdsfn Kgog Ego Yne"
    //   },
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    //   {
    //     "sendLang": "Can you tell me how can i go to Korean Goverment Varsity",
    //     "resultLang":
    //         "Ngeiw Rgerjer Kuregew Nerweew Kijdsf Ghere Khdsfn Kgog Ego Yne"
    //   },
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    //   {
    //     "sendLang": "Can you tell me how can i go to Korean Goverment Varsity",
    //     "resultLang":
    //         "Ngeiw Rgerjer Kuregew Nerweew Kijdsf Ghere Khdsfn Kgog Ego Yne"
    //   },
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    //   {"sendLang": "How are you", "resultLang": "Kgog Ego Yne"},
    // ];

    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue.withOpacity(0.2),
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite_border),
                const SizedBox(
                  width: 6.0,
                ),
                Text(
                  "Favorite",
                  style: GoogleFonts.openSans(fontSize: 24.0),
                ),
                const SizedBox(
                  width: 30.0,
                )
              ],
            )),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  //opacity: 0.9,
                  image: AssetImage(
                    randomBg,
                  ),
                  fit: BoxFit.cover)),
          child: GlassmorphicContainer(
            width: size.width,
            height: size.height,
            borderRadius: 0,
            blur: 10,
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
            child: Obx(() {
              return homeController.isFething.value == false
                  ? homeController.padList.isNotEmpty
                      ? ListView.builder(
                          controller: scrollcontroller,
                          itemCount: homeController.padList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              title: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    color: Colors.pink.withOpacity(0.1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        homeController.padList[index].sendLang,
                                        style: GoogleFonts.openSans(
                                            fontSize: 17.0, color: bgColor),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          homeController.delete(homeController
                                              .padList[index].id!);
                                          homeController.fetch();
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.white.withOpacity(0.4),
                                        )),
                                  ],
                                ),
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(7.0),
                                        bottomRight: Radius.circular(7.0)),
                                    color: Colors.blue.withOpacity(0.1)),
                                child: Text(
                                  homeController.padList[index].resultLang,
                                  style: GoogleFonts.openSans(
                                      fontSize: 15.0, color: titleColor),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text(
                            "Empty",
                            style: GoogleFonts.openSans(fontSize: 17.0),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
          ),
        ));
  }
}
