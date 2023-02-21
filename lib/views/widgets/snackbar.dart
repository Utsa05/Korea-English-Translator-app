// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korea_to_english_translator/views/constants/colors.dart';

appSnackBar(BuildContext context, String content) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
    content: Text(
      content,
      style: GoogleFonts.openSans(color: whitColor),
    ),
    elevation: 0.0,
    padding: const EdgeInsets.all(10.0),
    behavior: SnackBarBehavior.floating,
    backgroundColor: blackColor.withOpacity(0.3),
  ));
}
