// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:aking/size_config.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: body1Hint,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: hexToColor("#EDEDED")),
    ),
  );
}

TextTheme textTheme() {
  return TextTheme(
    // bodyText1: TextStyle(color: kTextColor),
    // bodyText2: TextStyle(color: kTextColor),
    headline4: _headline4,
    headline6: _headline6,
    subtitle1: _subtitle1,
    bodyText1: _bodyText1,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: hexToColor("#8B8B8B"), fontSize: 18),
    ),
  );
}


TextStyle body1Hint = _bodyText1.copyWith(color: hexToColor("#c6c6c6"));

TextStyle _headline4 = TextStyle(
    color: Colors.black,
    fontSize: getProportionateScreenHeight(32),
    height: getProportionateScreenHeight(41 / 32),
    fontWeight: FontWeight.bold);

TextStyle _headline6 = TextStyle(
    fontSize: getProportionateScreenHeight(20),
    color: Colors.black,
    height: getProportionateScreenHeight(25 / 20),
    fontWeight: FontWeight.w600);

TextStyle _subtitle1 = TextStyle(
    fontSize: getProportionateScreenHeight(18),
    color: Colors.black,
    height: getProportionateScreenHeight(22 / 20),
    fontWeight: FontWeight.bold);

TextStyle _bodyText1 = TextStyle(
    fontSize: getProportionateScreenHeight(16),
    color: hexToColor("#313131"),
    height: getProportionateScreenHeight(20 / 16),
    fontWeight: FontWeight.w500);

  // /// Main Title
  // static const TextStyle _mainTitle = TextStyle(
  //   fontFamily: "Muli",
  //   fontWeight: FontWeight.w700,
  //   fontSize: 36,
  // );

  // /// Title
  // static const TextStyle _title = TextStyle(
  //   fontFamily: "Muli",
  //   fontWeight: FontWeight.w700,
  //   fontSize: 28,
  // );

  // /// Subtitle
  // static const TextStyle _subtitle = TextStyle(
  //   fontFamily: "Muli",
  //   fontWeight: FontWeight.w600,
  //   fontSize: 18,
  // );

  // /// Body
  // static const TextStyle _body = TextStyle(
  //   fontFamily: "Muli",
  //   fontWeight: FontWeight.w500,
  //   fontSize: 16,
  // );

  // /// Detail
  // static const TextStyle _detail = TextStyle(
  //   fontFamily: "Muli",
  //   fontWeight: FontWeight.w400,
  //   fontSize: 14,
  // );
