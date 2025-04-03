import 'package:flutter/material.dart';

class AppColors {
  static Color primary = HexColor.fromHex("#FD714A");
  static Color errorRed = HexColor.fromHex("#F55459");
  static Color backgroundColor = HexColor.fromHex("#FFFDF6");
  static Color black = HexColor.fromHex("#1E1E1E");
  static Color grey = HexColor.fromHex("#AAAAAA");
  static Color disableGrey = HexColor.fromHex("#C6C6C6");
  static Color yellow = HexColor.fromHex("#FEEA31");
  static Color green = HexColor.fromHex("#A4E4E0");
  static Color pink = HexColor.fromHex("#F9AFBC");
  static Color purple = HexColor.fromHex("#DEDAFD");
  static Color blue = HexColor.fromHex("#B3D9F7");
  static Color chatDate = HexColor.fromHex("#F3F3F3");
  static Color primaryBg = HexColor.fromHex("#FEEFEF");
  static Color buttonBg = HexColor.fromHex("#282828");
  static Color white = Colors.white;
  static Color blackColor = Colors.black;
  static Color transparent = Colors.transparent;
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
