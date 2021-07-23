// 🐦 Flutter imports:
import 'package:aking/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aking/constants.dart';
import 'package:aking/routes.dart';
import 'package:aking/size_config.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'app_theme.dart';

Future main() async {
  /// Ensure Initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
            StreamProvider<User?>.value(value: AuthServices().user, initialData: null)
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Todo List",
            theme: appTheme(),
            initialRoute: splashScreenPath,
            routes: routes,
          ),
        );
      });
    });
  }
}
