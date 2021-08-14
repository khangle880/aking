// 🐦 Flutter imports:
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputDecorationTheme _inputDecorationLightTheme() {
    return InputDecorationTheme(
      errorStyle: TextStyle(
          fontFamily: "Avenir Next Rounded Pro", fontWeight: FontWeight.w500),
      hintStyle: _bodyText2.copyWith(color: hexToColor("#c6c6c6")),
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
      iconTheme: IconThemeData(color: hexToColor("#313131")),
      textTheme: TextTheme(
        headline6: _headline6,
      ),
    );
  }

  static final TextStyle _headline3 = TextStyle(
      color: hexToColor("#010101"),
      fontSize: 48.sp,
      fontWeight: FontWeight.w600);

  static final TextStyle _headline4 = TextStyle(
      color: hexToColor("#313131"),
      fontSize: 32.sp,
      fontWeight: FontWeight.w600);

  static final TextStyle _headline5 = TextStyle(
      fontSize: 24.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w600);

  static final TextStyle _headline6 = TextStyle(
      fontSize: 20.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w500);

  static final TextStyle _subtitle1 = TextStyle(
      fontSize: 18.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w600);

  static final TextStyle _subtitle2 = TextStyle(
      fontSize: 14.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w600);

  static final TextStyle _bodyText1 = TextStyle(
      fontSize: 18.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w500);

  static final TextStyle _bodyText2 = TextStyle(
      fontSize: 16.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w400);

  static final TextStyle _button = TextStyle(
      fontSize: 16.sp,
      color: hexToColor("#313131"),
      fontWeight: FontWeight.w500);

  static TextTheme _textLightTheme() {
    return TextTheme(
      headline3: _headline3,
      headline4: _headline4,
      headline5: _headline5,
      headline6: _headline6,
      subtitle1: _subtitle1,
      subtitle2: _subtitle2,
      bodyText1: _bodyText1,
      bodyText2: _bodyText2,
      button: _button,
    );
  }

  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Avenir Next Rounded Pro",
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
