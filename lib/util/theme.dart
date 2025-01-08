import 'package:flutter/material.dart';
import 'package:rieng/resources/color.dart';

class Themes {
  static final light = ThemeData(
      fontFamily: 'Urbanist',
      primaryColor: ColorList.primaryClr,
      brightness: Brightness.light);

  static final dark = ThemeData(
      fontFamily: 'Urbanist',
      primaryColor: ColorList.darkGreyClr,
      brightness: Brightness.dark);
}
