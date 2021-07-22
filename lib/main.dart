// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:aking/constants.dart';
import 'package:aking/routes.dart';
import 'package:aking/size_config.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'app_theme.dart';

void main() {
  /// Ensure Initialized
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Todo List",
          theme: appTheme(),
          initialRoute: splashScreenPath,
          routes: routes,
        );
      });
    });
  }
}
