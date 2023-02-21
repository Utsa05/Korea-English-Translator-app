// ignore_for_file: unused_import, depend_on_referenced_packages, avoid_print

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'dart:io';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:korea_to_english_translator/views/widgets/snackbar.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  var textController = TextEditingController().obs;
  var sendLang = "Korea".obs;
  var resultLang = "English".obs;
  var displayMyWidget = true.obs;
  var translatorText = "".obs;
  var isTranslating = false.obs;
  var prevText = "".obs;
  var prevTanslateText = "".obs;

  final stt.SpeechToText _speech = stt.SpeechToText();

  var speechEnabled = false.obs;
  var isListening = false.obs;
  var text = 'default'.obs;

  void swapLanguage() {
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
}
