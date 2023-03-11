import 'package:flutter/material.dart';

class MyThemes {
  //dark theme
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
  );

  //light theme
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
  );
}
