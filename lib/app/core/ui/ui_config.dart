import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'TMDB';
  static ThemeData get theme => ThemeData(
    primaryColor: const Color(0xff032541),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff032541)
    )
  );
}
