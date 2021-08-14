import 'package:flutter/material.dart';

class CustomPopupMenuItem {
  Color backgroundColor;
  Widget title;
  Widget? trailingIcon;
  Function onPressed;

  CustomPopupMenuItem(
      {this.backgroundColor = Colors.white,
      required this.title,
      this.trailingIcon,
      required this.onPressed});
}
