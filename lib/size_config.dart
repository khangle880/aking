// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Configure for size
class SizeConfig {
  /// Screen Width
  static late double screenWidth;
  /// Screen Height
  static late double screenHeight;

  /// Initial Configure
  void init(BoxConstraints constraints, Orientation orientation) {
    screenWidth = constraints.maxWidth;
    screenHeight = constraints.maxHeight;
  }
}

/// Get media width
double getMediaWidth() {
  return SizeConfig.screenWidth;
}

/// Get media height
double getMediaHeight() {
  return SizeConfig.screenHeight;
}

/// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  const double devSizeHeight = 812.0;
  final double screenHeight = SizeConfig.screenHeight;
  return inputHeight / devSizeHeight * screenHeight;
}

/// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  const double devSizeWidth = 375.0;
  final double screenWidth = SizeConfig.screenWidth;
  return inputWidth / devSizeWidth * screenWidth;
}

/// Convert hex code to color
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
