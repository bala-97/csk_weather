import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme of the app.
class MainTheme {

  /// Light theme of the app
  ThemeData lightTheme = ThemeData(
    brightness: _lightColorScheme().brightness,
    backgroundColor: _lightColorScheme().background,
    colorScheme: _lightColorScheme(),
    textTheme:
        _textTheme(_lightColorScheme().brightness).apply(bodyColor: Colors.black87, displayColor: Colors.black87),
  );

  static ColorScheme _lightColorScheme() => const ColorScheme.light(
        background: Color(0xfff7f5f6),
      );

  /// Dark theme of the app
  ThemeData darkTheme = ThemeData(
      brightness: _darkColorScheme().brightness,
      textTheme: _textTheme(_darkColorScheme().brightness).apply(bodyColor: Colors.white, displayColor: Colors.white),
      colorScheme: _darkColorScheme());

  static ColorScheme _darkColorScheme() => const ColorScheme.dark(
        background: Color(0xff262626),
      );

  /// Text theme is common for light and dark themes
  static TextTheme _textTheme(Brightness brightness) {
    return TextTheme(
      headline1: GoogleFonts.nunito(fontSize: 76, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      headline2: GoogleFonts.nunito(fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      headline3: GoogleFonts.nunito(fontSize: 51, fontWeight: FontWeight.w400),
      headline4: GoogleFonts.nunito(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w400),
      headline6: GoogleFonts.nunito(fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subtitle1: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle2: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyText1: GoogleFonts.sourceSansPro(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyText2: GoogleFonts.sourceSansPro(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button: GoogleFonts.sourceSansPro(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption: GoogleFonts.sourceSansPro(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: GoogleFonts.sourceSansPro(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    );
  }
}
