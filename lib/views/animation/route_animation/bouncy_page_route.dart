// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder {
  Widget widget;

  BouncyPageRoute({required this.widget})
      : super(
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(scale: animation, child: child);
          },
          pageBuilder: (context, animation, secondaryAnimation) => widget,
        );
}
