// ignore_for_file: unused_import, depend_on_referenced_packages, avoid_print, use_build_context_synchronously

import 'package:korea_to_english_translator/model/translate.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:korea_to_english_translator/views/widgets/snackbar.dart';
import 'package:translator/translator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeController extends GetxController {
  var textController = TextEditingController().obs;
  var sendLang = "Korea".obs;
  var resultLang = "English".obs;
  var displayMyWidget = true.obs;
  var translatorText = "".obs;
  var isTranslating = false.obs;
  var prevText = "".obs;
  var prevTanslateText = "".obs;
  var saveText = "".obs;

  final stt.SpeechToText _speech = stt.SpeechToText();

  var speechEnabled = false.obs;
  var isListening = false.obs;
  var text = 'default'.obs;

  var textScanning = false.obs;
  var imageFile = XFile("path").obs;
  var scannedText = "".obs;

  final ImagePicker picker = ImagePicker();

  //db
  var isFething = true.obs;
  var padList = <TranslateModel>[].obs;

  //methods

  void swapLanguage() {
    prevText.value = "";
    if (sendLang.value == "Korea") {
      sendLang.value = "English";
      resultLang.value = "Korea";
    } else {
      sendLang.value = "Korea";
      resultLang.value = "English";
    }
  }

  void translateNow(
      {required String from,
      required String to,
      required BuildContext context}) async {
    isTranslating.value = true;
    translatorText.value = "";
    try {
      if (prevText.value != textController.value.text) {
        final translator = GoogleTranslator();

        await translator
            .translate(textController.value.text, from: from, to: to)
            .then((value) {
          translatorText.value = value.text;
          print(translatorText.value);
          prevText.value = textController.value.text;
          prevTanslateText.value = translatorText.value;
          saveText.value = textController.value.text;
        });
      } else {
        translatorText.value = prevTanslateText.value;
        appSnackBar(context, "Already Translated");
      }
    } on SocketException {
      appSnackBar(context, "No Internet Connection");
    } catch (e) {
      isTranslating.value = false;
      print(e);
    } finally {
      isTranslating.value = false;
    }
  }

  void listen(BuildContext context) async {
    if (!isListening.value) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'done') {
            textController.value.text = text.value;
            isListening.value = false;
            Navigator.pop(context);
          }
        },
        onError: (val) {
          print('onError: $val');
          //appSnackBar(context, "Nothing Lisened");
        },
      );
      if (available) {
        isListening.value = true;
        _speech.listen(onResult: (val) {
          text.value = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {}
        });
      }
    } else {
      isListening.value = false;
      _speech.stop();
    }
  }

  void getImage(BuildContext context, ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning.value = true;
        imageFile.value = pickedImage;

        getRecognisedText(pickedImage);
      } else {
        appSnackBar(context, "Image Not Selected");
      }
    } catch (e) {
      textScanning.value = false;
      imageFile.value = XFile("path");
      scannedText.value = "Error occured while scanning";
    }
  }

  void getRecognisedText(XFile image) async {
    Get.bottomSheet(
      SizedBox(
        height: 100.0,
        child: Column(
          children: [
            Center(
              child:
                  Lottie.asset('assets/lotties/Artboard.json', height: 100.0),
            ),
          ],
        ),
      ),
      backgroundColor: whitColor.withOpacity(0.2),
      isDismissible: false,
      enableDrag: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText.value = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText.value = "${scannedText + line.text}\n";
      }
    }
    textScanning.value = false;
    textController.value.text = scannedText.value;
    print(scannedText.value);
    Get.back();
    print("done Rec");
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  fetch() async {
    padList.value = await fetchList().whenComplete(() {
      isFething.value = false;
      print("Congress Feched");
      print(padList.length);
    });
  }

  //db
  String dbName = 'MYDB.db';
  Future<Database> initDb() async {
    final filePath = await getDatabasesPath();
    final path = join(filePath, dbName);

    return openDatabase(path, onCreate: (database, version) async {
      String textTYPE = 'TEXT NOT NULL';
      String idTYPE = 'INTEGER PRIMARY KEY AUTOINCREMENT';

      await database.execute('''
        CREATE TABLE MYDB(
          id $idTYPE,
          sendLang $textTYPE,
          resultLang $textTYPE
        )
        
        ''');
    }, version: 1);
  }

  Future<bool> insert(TranslateModel translateModel) async {
    Database db = await initDb();
    db.insert('MYDB', translateModel.joMap());
    fetch();
    return true;
  }

  Future<List<TranslateModel>> fetchList() async {
    Database db = await initDb();
    List<Map<String, Object?>> translateList = await db.query('MYDB');

    return translateList.map((e) => TranslateModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    Database db = await initDb();
    return await db.delete(
      'MYDB',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    Database db = await initDb();

    return db.close();
  }
}
