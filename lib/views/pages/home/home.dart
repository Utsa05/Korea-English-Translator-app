// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korea_to_english_translator/model/translate.dart';
import 'package:lottie/lottie.dart';
import 'package:korea_to_english_translator/controller/home.dart';
import 'package:korea_to_english_translator/views/constants/assets.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';
import 'package:korea_to_english_translator/views/pages/home/components/drawer.dart';
import 'package:korea_to_english_translator/views/widgets/snackbar.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _homeController = Get.put(HomeController());
  bool animated = false;

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _loadBannerAd('ca-app-pub-3080837536061201/2182987194');

    super.initState();
  }

  void _loadBannerAd(String adId) {
    _bannerAd = BannerAd(
      adUnitId: adId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: AppDrawer(size: size),
        key: _scaffoldKey,
        appBar: appBar(_scaffoldKey, _homeController),
        extendBodyBehindAppBar: true,
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
                    TypeView(
                      size: size,
                      homeController: _homeController,
                    ),
                    ResultView(
                      size: size,
                      homeController: _homeController,
                    ),
                  ],
                ),
              )),
        ),
        bottomNavigationBar: _isBannerAdReady
            ? Container(
                color: bgColor,
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              )
            : const SizedBox());
  }

  AppBar appBar(GlobalKey<ScaffoldState> key, HomeController controller) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          splashRadius: 20.0,
          onPressed: () {
            key.currentState!.openDrawer();
          },
          icon: Image.asset(
            'assets/icons/hamburger.png',
            width: 28.0,
            color: blackColor,
          )),
      centerTitle: true,
      title: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 65.0,
              child: AnimatedDefaultTextStyle(
                curve: Curves.fastLinearToSlowEaseIn,
                style: animated
                    ? GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: titleColor,
                        fontWeight: FontWeight.w500)
                    : GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: titleColor,
                        fontWeight: FontWeight.w500),
                duration: Duration(milliseconds: 200),
                child: Text(
                  controller.sendLang.value,
                ),
              ),
            ),
            SizedBox(
              width: controller.sendLang.value == "English" ? 6.0 : 0,
            ),
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
                  onPressed: () {
                    setState(() {
                      animated = !animated;
                    });
                    controller.swapLanguage();
                  },
                  icon: const Icon(
                    Icons.compare_arrows_outlined,
                    color: whitColor,
                  ),
                )),
            SizedBox(
              width: 14.0,
            ),
            SizedBox(
              width: 65.0,
              child: AnimatedDefaultTextStyle(
                curve: Curves.bounceInOut,
                style: animated == false
                    ? GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: titleColor,
                        fontWeight: FontWeight.w500)
                    : GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: titleColor,
                        fontWeight: FontWeight.w500),
                duration: Duration(milliseconds: 200),
                child: Text(
                  controller.resultLang.value,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        );
      }),
    );
  }
}

class ResultView extends StatefulWidget {
  const ResultView({
    Key? key,
    required this.size,
    required this.homeController,
  }) : super(key: key);

  final Size size;
  final HomeController homeController;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  bool _isSpeaching = false;
  TextToSpeech tts = TextToSpeech();
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
        width: widget.size.width,
        height: widget.size.height * 0.3,
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
        child: Obx(() {
          return widget.homeController.isTranslating.value == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 14.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Obx(() {
                          return Text(
                            widget.homeController.translatorText.value,
                            style: GoogleFonts.openSans(color: blackColor),
                            textAlign: TextAlign.start,
                          );
                        }),
                      ),
                    )),
                    Obx(() => widget
                            .homeController.textController.value.text.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleButton(
                                  icon: Icons.favorite_border_outlined,
                                  color: bgColor,
                                  tap: () {
                                    if (widget.homeController.textController
                                        .value.text.isNotEmpty) {
                                      widget.homeController.insert(
                                          TranslateModel(
                                              sendLang:
                                                  widget
                                                      .homeController
                                                      .textController
                                                      .value
                                                      .text,
                                              resultLang: widget.homeController
                                                  .translatorText.value));

                                      appSnackBar(context, "Added To Favorite");
                                    } else {
                                      appSnackBar(
                                          context, "Please Translate First");
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                CircleButton(
                                  icon: Icons.copy_outlined,
                                  color: bgColor,
                                  tap: () {
                                    if (widget.homeController.translatorText
                                        .isNotEmpty) {
                                      FlutterClipboard.copy(widget
                                              .homeController
                                              .translatorText
                                              .value)
                                          .then((value) => print('copied'));

                                      appSnackBar(context, "Coppied");
                                    } else {
                                      appSnackBar(context,
                                          "Please Your Need Translate First");
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                CircleButton(
                                  icon: Icons.share_outlined,
                                  color: bgColor,
                                  tap: () {
                                    if (widget.homeController.translatorText
                                        .isNotEmpty) {
                                      Share.share(
                                          'Share from Korea to English Translator app\n\n${widget.homeController.sendLang.value}:${widget.homeController.textController.value.text}\n${widget.homeController.resultLang.value}:${widget.homeController.translatorText.value}\n\nGoogle Playstore',
                                          subject: 'Translated');

                                      appSnackBar(context, "Coppied");
                                    } else {
                                      appSnackBar(context,
                                          "Please Your Need Translate First");
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                CircleButton(
                                  icon: _isSpeaching == false
                                      ? Icons.play_arrow_outlined
                                      : Icons.pause_outlined,
                                  color: bgColor,
                                  tap: () async {
                                    if (widget.homeController.translatorText
                                        .isNotEmpty) {
                                      if (_isSpeaching == false) {
                                        _isSpeaching = true;
                                        tts.speak(widget.homeController
                                            .translatorText.value);

                                        // if (await tts.stop() == true) {
                                        //   _isSpeaching = false;
                                        // }
                                      } else {
                                        tts.stop();
                                        _isSpeaching = false;
                                      }

                                      setState(() {});
                                    } else {
                                      appSnackBar(context,
                                          "Please Your Need Translate First");
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        : const SizedBox())
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: blackColor.withOpacity(0.2),
                ));
        }));
  }
}

class TypeView extends StatefulWidget {
  const TypeView({
    super.key,
    required this.size,
    required this.homeController,
  });

  final Size size;
  final HomeController homeController;

  @override
  State<TypeView> createState() => _TypeViewState();
}

class _TypeViewState extends State<TypeView> {
  InterstitialAd? _interstitialAd;
  bool _isFirstTime = true;
  int numofitemClick = 0;

  @override
  void initState() {
    _createInterstitialAd();
    super.initState();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3080837536061201/7243742187',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;

            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void counterFun() {
    if (_isFirstTime == true) {
      _showInterstitialAd();
      _isFirstTime = false;
    }
    if (_interstitialAd == null) {
      _createInterstitialAd();
    }
    if (numofitemClick <= 3) {
      numofitemClick++;
    } else {
      _showInterstitialAd();
      numofitemClick = 0;
    }
    print(numofitemClick);
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        // _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        margin: const EdgeInsets.only(top: 100.0, left: 15.0, right: 15.0),
        width: widget.size.width,
        height: widget.size.height * 0.3,
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
              controller: widget.homeController.textController.value,
              style: GoogleFonts.openSans(color: titleColor),
              maxLines: 12,
              cursorColor: bgColor,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.openSans(color: titleColor),
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
                children: [
                  CircleButton(
                    icon: Icons.bookmark_outline_outlined,
                    color: bgColor,
                    tap: () {
                      if (widget.homeController.saveText.value.isNotEmpty) {
                        if (widget.homeController.textController.value.text !=
                            widget.homeController.saveText.value) {
                          widget.homeController.textController.value.text =
                              widget.homeController.saveText.value;

                          counterFun();
                        } else {
                          appSnackBar(context, "No Need to Change");
                        }
                      } else {
                        appSnackBar(context, "Nothing Saved");
                      }
                    },
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.camera_alt_outlined,
                    color: bgColor,
                    tap: () {
                      // homeController.getImage(
                      //   context,
                      //   ImageSource.gallery,
                      // );

                      showModalBottomSheet(
                          // isDismissible: false,
                          // enableDrag: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          context: context,
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          builder: (builder) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100.0, vertical: 15.0),
                              child: Container(
                                width: 300.0,
                                height: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: whitColor.withOpacity(0.2)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Choose",
                                          style: GoogleFonts.openSans(
                                              color: whitColor, fontSize: 18.0),
                                        ),
                                        IconButton(
                                            splashRadius: 15.0,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close_outlined,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      child: Divider(
                                        color: whitColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              blackColor.withOpacity(0.5),
                                          child: IconButton(
                                              splashRadius: 25.0,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                widget.homeController.getImage(
                                                    context,
                                                    ImageSource.camera);
                                              },
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                color: bgColorPro,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              blackColor.withOpacity(0.5),
                                          child: IconButton(
                                              splashRadius: 25.0,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                widget.homeController.getImage(
                                                    context,
                                                    ImageSource.gallery);

                                                counterFun();
                                              },
                                              icon: Icon(
                                                Icons.save_outlined,
                                                color: bgColor,
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                      counterFun();
                    },
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CircleButton(
                    icon: Icons.mic_outlined,
                    color: bgColor,
                    tap: () {
                      widget.homeController.listen(context);
                      showModalBottomSheet(
                          isDismissible: false,
                          enableDrag: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          context: context,
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          builder: (builder) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: whitColor.withOpacity(0.2)),
                                child: Lottie.asset('assets/lotties/mic.json'),
                              ),
                            );
                          });
                      counterFun();
                    },
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  // CircleButton(
                  //   icon: Icons.draw_outlined,
                  //   color: bgColor,
                  // ),
                  // SizedBox(
                  //   width: 12.0,
                  // ),
                  CircleButton(
                    icon: Icons.close,
                    color: redColor,
                    tap: () {
                      if (widget.homeController.textController.value.text
                          .isNotEmpty) {
                        widget.homeController.textController.value.clear();
                        counterFun();
                      } else {
                        appSnackBar(context, "Nothing Typed");
                      }
                    },
                  ),

                  SizedBox(
                    width: 12.0,
                  ),
                  IconButton(
                      onPressed: () {
                        if (widget.homeController.textController.value.text
                            .isNotEmpty) {
                          if (widget.homeController.sendLang.value == "Korea") {
                            widget.homeController.translateNow(
                                from: 'ko', to: 'en', context: context);
                          } else {
                            widget.homeController.translateNow(
                                from: 'en', to: 'ko', context: context);
                          }

                          counterFun();
                        } else {
                          appSnackBar(context, "Pleasy Type Somthing");
                        }
                      },
                      icon: Icon(
                        Icons.send_outlined,
                        color: bgColor,
                      ))
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
    required this.tap,
  });

  final IconData icon;
  final Color color;
  final GestureTapCallback tap;
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
          onPressed: tap,
          icon: Icon(
            icon,
            color: color,
          ),
        ));
  }
}
