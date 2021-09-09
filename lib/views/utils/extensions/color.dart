import 'package:flutter/material.dart';

extension ExpandedColor on Color {
  static Color fromHex(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  String toHex() {
    return '#${value.toRadixString(16).substring(2, 8)}';
  }
}
