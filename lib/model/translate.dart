import 'dart:core';

class TranslateModel {
  TranslateModel({
    this.id,
    required this.sendLang,
    required this.resultLang,
  });
  int? id;
  String sendLang;
  String resultLang;

  factory TranslateModel.fromMap(Map<String, dynamic> map) => TranslateModel(
        id: map['id'] as int,
        sendLang: map['sendLang'] as String,
        resultLang: map['resultLang'] as String,
      );

  Map<String, dynamic> joMap() => {
        'id': id,
        'sendLang': sendLang,
        'resultLang': resultLang,
      };
}
