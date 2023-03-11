//code for changing themes 
import 'package:flutter/material.dart';

//sets the color theme and change font color
class ColorTheme {
  static Color getTheme(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) return Colors.white;

    return Colors.black;
  }

  static Color getThemeInv(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) return Colors.white;

    return Colors.black;
  }
}
