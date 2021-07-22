
import 'package:flutter/cupertino.dart';
import 'package:aking/constants.dart';
import 'package:aking/routes/auth/forgot_password/forgot_password_screen.dart';
import 'package:aking/routes/auth/sign_in/sign_in_screen.dart';
import 'package:aking/routes/splash/splash_screen.dart';
import 'package:aking/routes/walkthrough/walkthrough_screen.dart';

final Map<String, WidgetBuilder> routes = {
  splashScreenPath: (context) => const SplashScreen(),
  walkthroughPath: (context) => const WalkthroughScreen(),
  signInPath: (context) => const SignInScreen(),
  forgotPasswordPath: (context) => const ForgotPasswordScreen()
};
