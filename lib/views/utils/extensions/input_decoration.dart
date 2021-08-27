import 'package:flutter/material.dart';

extension ExpandedInputDecoration on InputDecoration {
  InputDecoration toNoneBorder() {
    return copyWith(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
  }
}
