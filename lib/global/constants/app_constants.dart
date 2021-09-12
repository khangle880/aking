// 🐦 Flutter imports:
import 'package:flutter/material.dart';


/// Color constants use for app
class ColorConstants {
  /// Primary Color constant
  static const Color kPrimaryColor = Color(0xFFFF7643);
  /// 
  static const Color kPrimaryLightColor = Color(0xFFFFECDF);

  /// Primary gradient color
  static const LinearGradient kPrimaryGradientColor = LinearGradient(
    // begin: Alignment.centerLeft,
    // end: Alignment.centerRight,
    colors: [Color(0xFFF68888), Color(0xFFF96060)],
  );

  ///
  static const Color kSecondaryColor = Color(0xFF979797);
  ///
  static const Color kTextColor = Color(0xFF757575);
  /// List Color constant pick up for theme of project, check list, note,...
  static const List<Color> kListColorPickup = [
    Color(0xFF6074F9),
    Color(0xFFE42B6A),
    Color(0xFF5ABB56),
    Color(0xFF3D3A62),
    Color(0xFFF4CA8F),
  ];
}

/// Constants for app
class AppConstants {
  /// Animation duration const
  static const Duration kAnimationDuration = Duration(milliseconds: 200);
}
