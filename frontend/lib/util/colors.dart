import 'package:flutter/material.dart';

class AppColors {
  static const Color lightGreen = Color.fromRGBO(229, 245, 228, 1);
  static const Color darkGreen = Color.fromRGBO(42, 82, 81, 1);
  static const Color blueGreen = Color.fromRGBO(229, 245, 228, 1);
  static const Color blackGreen = Color.fromRGBO(38, 45, 37, 1);
  static const Color darkWhite = Color.fromRGBO(247, 247, 247, 1);
  static const Color lightWhite = Color.fromRGBO(252, 252, 252, 1);
  static const Color darkGrey = Color.fromRGBO(40, 40, 40, 1);

  static Color bgColor = Colors.white;
  static Color recBgColor = Colors.white;
  static Color textColor = Colors.white;
  static Color drawerColor = Colors.white;

  AppColors(bool isDarkMode) {
    if (isDarkMode) {
      bgColor = Colors.black;
      recBgColor = darkGrey;
      textColor = Colors.white;
      drawerColor = darkGreen;
    } else {
      bgColor = Colors.white;
      recBgColor = lightWhite;
      textColor = Colors.black;
      drawerColor = lightGreen;
    }
  }
}
