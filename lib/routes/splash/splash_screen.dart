// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'components/splash_content.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Starting screen
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(child: SplashContent(text: "aking")));
  }
}
