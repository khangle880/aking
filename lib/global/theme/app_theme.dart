// 🐦 Flutter imports:
import 'package:aking/size_config.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputDecorationTheme _inputDecorationLightTheme() {
    return InputDecorationTheme(
      hintStyle: _bodyText1.copyWith(color: hexToColor("#c6c6c6")),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: hexToColor("#EDEDED")),
      ),
    );
  }

  static AppBarTheme _appBarLightTheme() {
    return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline6: _headline6,
      ),
    );
  }

  static final TextStyle _headline4 = TextStyle(
      color: Colors.black,
      fontSize: (32) * SizeConfig.screenHeightBase,
      height: (41 / 32) * SizeConfig.screenHeightBase,
      fontWeight: FontWeight.bold);

  static final TextStyle _headline6 = TextStyle(
      fontSize: (20) * SizeConfig.screenHeightBase,
      color: Colors.black,
      height: (25 / 20) * SizeConfig.screenHeightBase,
      fontWeight: FontWeight.w600);

  static final TextStyle _subtitle1 = TextStyle(
      fontSize: (18) * SizeConfig.screenHeightBase,
      color: Colors.black,
      height: (22 / 20) * SizeConfig.screenHeightBase,
      fontWeight: FontWeight.bold);

  static final TextStyle _bodyText1 = TextStyle(
      fontSize: (16) * SizeConfig.screenHeightBase,
      color: hexToColor("#313131"),
      height: (20 / 16) * SizeConfig.screenHeightBase,
      fontWeight: FontWeight.w500);

  static TextTheme _textLightTheme() {
    return TextTheme(
      headline4: _headline4,
      headline6: _headline6,
      subtitle1: _subtitle1,
      bodyText1: _bodyText1,
    );
  }

  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Muli",
      appBarTheme: _appBarLightTheme(),
      textTheme: _textLightTheme(),
      inputDecorationTheme: _inputDecorationLightTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData dark() {
    return ThemeData.dark();
  }
}
