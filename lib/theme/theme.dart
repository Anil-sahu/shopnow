// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
        headline6: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: base.headline6!.color,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        subtitle1: GoogleFonts.roboto(
            textStyle: TextStyle(color: base.subtitle1!.color, fontSize: 18)),
        subtitle2: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: base.subtitle2!.color,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        bodyText2: GoogleFonts.roboto(
            textStyle: TextStyle(color: base.bodyText2!.color, fontSize: 16)),
        bodyText1: GoogleFonts.roboto(
            textStyle: TextStyle(color: base.bodyText1!.color, fontSize: 14)),
        button: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: base.button!.color,
                fontSize: 14,
                fontWeight: FontWeight.w500)));
  }

  static ThemeData lightTheme = ThemeData(
      hoverColor: Colors.grey,
      errorColor: Colors.red,
      shadowColor: const Color.fromRGBO(217, 215, 218, 1),
      selectedRowColor: const Color.fromARGB(255, 255, 73, 1),
      cardColor: Colors.white,
      highlightColor: const Color.fromRGBO(235, 235, 245, 1),
      backgroundColor: const Color.fromARGB(255, 241, 239, 235),
      scaffoldBackgroundColor: const Color.fromARGB(255, 241, 239, 235),
      // primaryColorLight: Colors.white,
      iconTheme:
          const IconThemeData(color: Color.fromRGBO(67, 70, 77, 1), size: 25),
      appBarTheme: const AppBarTheme(
        iconTheme:
            IconThemeData(color: Color.fromARGB(255, 231, 133, 120), size: 20),
        actionsIconTheme:
            IconThemeData(color: Color.fromRGBO(67, 70, 77, 1), size: 20),
        elevation: 0,
        titleTextStyle:
            TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 16),
        backgroundColor: Color.fromARGB(255, 255, 254, 252),
      ));
}
