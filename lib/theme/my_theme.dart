// ignore: unused_import
import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(8, 243, 104, 1);

  static final ThemeData myTheme = ThemeData(
      primaryColor: primary,
      brightness: Brightness.dark,
      fontFamily: 'roboto',
      appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 15,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary));
}
