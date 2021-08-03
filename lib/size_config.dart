// // 🐦 Flutter imports:
// import 'package:flutter/material.dart';

// /// Configure for size
// class SizeConfig {
//   /// Screen Width
//   static const double devSizeHeight = 812.0;
//   static late double screenHeight;
//   static late double screenWidthBase;

//   /// Screen Height
//   static const double devSizeWidth = 375.0;
//   static late double screenWidth;
//   static late double screenHeightBase;

// // static bool isPortrait = true;
// //   static bool isMobilePortrait = false;



//   /// Initial Configure
//   void init(BoxConstraints constraints, Orientation orientation) {
//     screenWidth = constraints.maxWidth;
//     screenHeight = constraints.maxHeight;
//     if (orientation == Orientation.portrait) {
//       screenWidth = constraints.maxWidth;
//       screenHeight = constraints.maxHeight;
//       // isPortrait = true;
//       // if (_screenWidth < 450) {
//       //   isMobilePortrait = true;
//       // }
//     } else {
//       screenWidth = constraints.maxHeight;
//       screenHeight = constraints.maxWidth;
//       // isPortrait = false;
//       // isMobilePortrait = false;
//     }
//     screenHeightBase = devSizeHeight / screenHeight;
//     screenWidthBase = devSizeWidth / screenWidth;
//   }
// }

// /// Get media width
// double getMediaWidth() {
//   return SizeConfig.screenWidth;
// }

// /// Get media height
// double getMediaHeight() {
//   return SizeConfig.screenHeight;
// }

// // /// Get the proportionate height as per screen size
// // double getProportionateScreenHeight(double inputHeight) {
// //   final double screenHeight = SizeConfig.screenHeight;
// //   return inputHeight / devSizeHeight * screenHeight;
// // }

// // /// Get the proportionate width as per screen size
// // double getProportionateScreenWidth(double inputWidth) {
// //   final double screenWidth = SizeConfig.screenWidth;
// //   return inputWidth / devSizeWidth * screenWidth;
// // }

// /// Convert hex code to color

