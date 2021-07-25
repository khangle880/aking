import 'package:aking/routes/auth/forgot_password/forgot_password_page.dart';
import 'package:aking/routes/auth/sign_in/sign_in_page.dart';
import 'package:aking/routes/splash/splash_screen.dart';
import 'package:aking/routes/wrapper/wrapper.dart';
import 'package:aking/routing/routes.dart';
import 'package:aking/utils/route_exception.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.wrapperRoute:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      default:
        throw RouteException("Route not found");
    }
  }
}
