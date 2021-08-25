import 'package:aking/logic/blocs/reset_password/reset_password_bloc.dart';
import 'package:aking/logic/utils/exceptions/route_exception.dart';
import 'package:aking/views/animation/route_animation/bouncy_page_route.dart';
import 'package:aking/views/routes/auth/change_pass_success/success_screen.dart';
import 'package:aking/views/routes/auth/forgot_password/forgot_password_page.dart';
import 'package:aking/views/routes/auth/reset_password/reset_password_screen.dart';
import 'package:aking/views/routes/auth/sign_in/sign_in_page.dart';
import 'package:aking/views/routes/exception/exception_page.dart';
import 'package:aking/views/routes/home/add_pages/add_task/add_task_page.dart';
import 'package:aking/views/routes/home/home_page.dart';
import 'package:aking/views/routes/splash/splash_screen.dart';
import 'package:aking/views/routes/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class AppRoutes {
  AppRoutes._();
  static GlobalKey<NavigatorState> mainNav = GlobalKey();
  static GlobalKey<NavigatorState> appNav = GlobalKey();

  static Route<dynamic> onGenerateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRouteNames.wrapperRoute:
        return BouncyPageRoute(widget: Wrapper());
      case AppRouteNames.signInRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case AppRouteNames.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case AppRouteNames.resetPasswordRoute:
        if (settings.arguments == null) {
          debugPrint("Miss bloc value, can't to route");
          return MaterialPageRoute(builder: (_) => ExceptionPage());
        } else {
          return MaterialPageRoute(
              builder: (_) => ResetPasswordPage(
                    resetPasswordBloc: settings.arguments! as ResetPasswordBloc,
                  ));
        }
      case AppRouteNames.resetPassSuccessRoute:
        return MaterialPageRoute(builder: (_) => SuccessScreen());
      default:
        throw RouteException("Route not found");
    }
  }

  static Route<dynamic> onGenerateMainRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainRouteNames.initHomeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case MainRouteNames.addTaskRoute:
        return MaterialPageRoute(builder: (_) => AddTaskPage());
      default:
        throw RouteException("Route not found");
    }
  }
}
